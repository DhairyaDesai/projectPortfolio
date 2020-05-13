/*
 *
 * (c) Copyright desaidn@miamioh.edu
 * @author: Dhairya Desai
 * @course&section: CSE381 D
 * @date: April 8th, 2020
 * @assignment: Homework 6 | MT Stock Server
 * @professor: Dr. Dhananjai M. Rao
 * 
 */
#include <boost/asio.hpp>
#include <iostream>
#include <string>
#include <sstream>
#include <thread>
#include <memory>
#include <unordered_map>
#include <mutex>
#include <iomanip>
#include <vector>

// Setup a server socket to accept connections on the socket
using namespace boost::asio;
using namespace boost::asio::ip;
using namespace std;

// Alias to an unordered_map that holds account number and balance.
using Market = std::unordered_map<std::string, double>;

// A global hash-map that contains all the market information
Market marketMap; 

// A global mutex to be shared by threads
std::mutex mut; 

// Alias to a lock_guard that locks and unlocks the shared mutex
using Guard = std::lock_guard<std::mutex>; 

// Alias to a vector that holds the TransactionInfo
using TransactionInfo = std::vector<std::string>;

// A garbage-collected container to hold client I/O stream in threads
using TcpStreamPtr = std::shared_ptr<tcp::iostream>;

// forward declaration for url_decode
std::string url_decode(std::string str);

// HELPER_METHODS=================================================HELPER_METHODS
/**
 * sendData [rovides a HTTP 200 OK response back to the client with the 
 * appropriate message and content length for that message.
 * 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 * @param msg takes in the message sent by the appropriate command depending 
 * on the logic implemented in that command. 
 */
void sendData(std::ostream& os, std::string msg) {
    os << "HTTP/1.1 200 OK\r\n"
       << "Server: StockServer\r\n"
       << "Content-Length: " << msg.length() << "\r\n"
       << "Connection: Close\r\n"
       << "Content-Type: text/plain\r\n" 
       << "\r\n"
       << msg; 
}

/**
 * sendErr provides a HTTP404 NOT FOUND response back to the client. 
 * 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void sendErr(std::ostream& os) {
    os << "HTTP/1.1 404 Not Found\r\n"
       << "Content-Type: text/plain\r\n"
       << "Connection: Close\r\n"
       << "\r\n"
       << "Invalid request"; 
}

/**
 * resetStock performs the trans=reset command and clears out all stocks.
 * 
 * @param info takes in a copy of the info vector with commands to execute 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void resetStock(TransactionInfo info,  std::ostream& os) {
    marketMap.clear();
    string msg = "All stocks reset";
    sendData(os, msg);
}

/**
 * createStock performs the trans=create command and creates stock entry 
 * with price = 0 only if the stock does not exists. if the stock exists, it 
 * returns "stock [name of stock] already exists.
 * 
 * @param info takes in a copy of the info vector with commands to execute 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void createStock(TransactionInfo info,  std::ostream& os) {
    string msg = "";
    
    if (marketMap.find(info[1]) == marketMap.end()) {
        marketMap[info[1]] = 0;
        msg = "Stock " + info[1] + " created";
        sendData(os, msg);
    } else {
        msg = "Stock " + info[1] + " already exists";
        sendData(os, msg);
    }
}

/**
 * addStockPrice performs the trans=up command and adds the specified in price
 * to stock, if stock exists. else, returns "stock not found.
 * 
 * @param info takes in a copy of the info vector with commands to execute 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void addStockPrice(TransactionInfo info,  std::ostream& os) {
    string msg = "";
    
    if (marketMap.find(info[1]) == marketMap.end()) {
        msg = "Stock not found";
        sendData(os, msg);
    } else {
        double oldPrice = marketMap[info[1]];
        marketMap[info[1]] = oldPrice + stod(info[2]);
        msg = "Stock price updated";
        sendData(os, msg);
    }
}

/**
 * subStockPrice performs the trans=down command and subtracts the specified
 * price from stock, if stock exist. Else, returns "stock not found".
 * 
 * @param info takes in a copy of the info vector with commands to execute 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void subStockPrice(TransactionInfo info,  std::ostream& os) {
    string msg = "";
    
    if (marketMap.find(info[1]) == marketMap.end()) {
        msg = "Stock not found";
        sendData(os, msg);
    } else {
        double oldPrice = marketMap[info[1]];
        marketMap[info[1]] = oldPrice - stod(info[2]);
        msg = "Stock price updated";
        sendData(os, msg);
    }
}

/**
 * stockStatus performs the trans=status command and returns current stock 
 * price, with exactly 2 decimal places if the
 * stock exists in the marketMap.
 * 
 * @param info takes in a copy of the info vector with commands to execute 
 * @param os takes in the output stream to send data back to client as a refer-
 * ence
 */
void stockStatus(TransactionInfo info,  std::ostream& os) {
    string msg = "";
    
    if (marketMap.find(info[1]) == marketMap.end()) {
        msg = "Stock not found";
        sendData(os, msg);
    } else {
        double price = marketMap[info[1]]; 
        msg = "Stock " + info[1] + ": $";
        ostringstream oss; 
        oss << std::fixed << std::setprecision(2) << price; 
        msg += oss.str();
        sendData(os, msg);
    }    
}

/**
 * isValidRequest method validates the command line of the HTTP request and 
 * updates the info vector with the command, stock and price information.
 * 
 * @param cmdLine takes in the un-decoded command line as a copy.
 * @param info takes in the info vector of strings as reference so that it 
 * can update it appropriately.
 * 
 * @return method returns true if the string is valid, otherwise returns false.
 */
bool isValidRequest(std::string cmdLine, TransactionInfo& info) {
    bool ans = false;  // create the return boolean variable
    
    // Decode the 
    cmdLine = url_decode(cmdLine); 
                                   
    
    auto cmdPos = cmdLine.find('=');
    cmdLine = cmdLine.substr(cmdPos + 1, cmdLine.size() - cmdPos - 11);
    if (cmdLine.find("&stock=") != string::npos) {
        cmdLine.replace(cmdLine.find("&stock="), 7, " ");
    }
    
    if (cmdLine.find("&amount=") != string::npos) {
        cmdLine.replace(cmdLine.find("&amount="), 8, " ");
    }
    
    istringstream procLine(cmdLine);
    std::string line;
    
    while (procLine >> line) {
        info.push_back(line);
    }
    
    if ((info[0] == "reset") || (info[0] == "create") || (info[0] == "up") ||
                             (info[0] == "down") || (info[0] == "status")) {
        ans = true;
    }
    
    return ans;
}

/**
 * serveClient Processes the HTTP request sent from the client to discern whether or not
 * the commands are valid and if valid which command(s) need to be executed
 * to execute
 * 
 * @param is The input stream to read data from client.
 * @param os The output stream to send data to client.
 */
void serveClient(std::istream& is, std::ostream& os) {
    std::string cmdLine, line; 
    // locks the mutex to create critical section and correctly process
    // information if threads are used, unlocks at destructor.
    Guard lock(mut); 
    // read first line with the GET request and ignore the rest of the HTTP 
    // headers
    std::getline(is, cmdLine);
    while (std::getline(is, line) && line != "\r" && !line.empty()) {}
    
    // The cmdLine will contain the query string which is valid when: 
    //      1. trans=reset (clear out all stocks)
    //      2. trans=create... (create stock entry only if it does not exit
    //      3. trans=up... (update+add)
    //      4. trans=down... (update+subtract)
    //      5. trans=status... return current price 
    // ALL OTHER TRANSACTIONS -> "Invalid Request" 
    
    // A vector of strings that holds the cmd and the associated stock and 
    // amount value if it is present
    TransactionInfo info;
    
    // if statement that calls the isValidRequest method that returns true 
    // if the request is valid. The method also updates the vector with the 
    // appropriate sequence of commands so that index 0 has the command, index 1
    // has the stock name and index 2 has information about the amount. 
    if (isValidRequest(cmdLine, info)) {
        // if the request is true it executes the appropriate command
        if (info[0] == "reset") resetStock(info, os);
        if (info[0] == "create") createStock(info, os);
        if (info[0] == "up") addStockPrice(info, os);
        if (info[0] == "down") subStockPrice(info, os);
        if (info[0] == "status") stockStatus(info, os);
    } else {   
        // else it notifies the client that the request is invalid.
        sendErr(os);
    }
}

// END_OF_HELPER_METHODS===================================END_OF_HELPER_METHODS

/**
 * Top-level method to run a custom HTTP server to process bank
 * transaction requests using multiple threads. Each request should
 * be processed using a separate detached thread. This method just loops 
 * for-ever.
 *
 * @param server The boost::tcp::acceptor object to be used to accept
 * connections from various clients.
 */
void runServer(tcp::acceptor& server) {
    // Implement this method to meet the requirements of the
    // homework. See earlier labs on using detached threads with
    // web-server for examples.

    // Needless to say first you should create stubs for the various 
    // operations, write comments, and then implement the methods.
    //
    // First get the base case operational. Submit it via CODE for
    // extra testing. Then you can work on the multithreading case.
    
    while (true) { 
        TcpStreamPtr client = std::make_shared<tcp::iostream>();
        server.accept(*client->rdbuf());
        std::thread thr([client]() {
            serveClient(*client, *client); });
        thr.detach();
    }     
}

//-------------------------------------------------------------------
//  DO  NOT   MODIFY  CODE  BELOW  THIS  LINE
//-------------------------------------------------------------------

/** Convenience method to decode HTML/URL encoded strings.

    This method must be used to decode query string parameters
    supplied along with GET request.  This method converts URL encoded
    entities in the from %nn (where 'n' is a hexadecimal digit) to
    corresponding ASCII characters.

    \param[in] str The string to be decoded.  If the string does not
    have any URL encoded characters then this original string is
    returned.  So it is always safe to call this method!

    \return The decoded string.
*/
std::string url_decode(std::string str) {
    // Decode entities in the from "%xx"
    size_t pos = 0;
    while ((pos = str.find_first_of("%+", pos)) != std::string::npos) {
        switch (str.at(pos)) {
            case '+': str.replace(pos, 1, " ");
            break;
            case '%': {
                std::string hex = str.substr(pos + 1, 2);
                char ascii = std::stoi(hex, nullptr, 16);
                str.replace(pos, 3, 1, ascii);
            }
        }
        pos++;
    }
    return str;
}

// Helper method for testing.
void checkRunClient(const std::string& port);

/*
 * The main method that performs the basic task of accepting
 * connections from the user and processing each request using
 * multiple threads.
 */
int main(int argc, char** argv) {
    // Setup the port number for use by the server
    const int port = (argc > 1 ? std::stoi(argv[1]) : 0);
    io_service service;
    // Create end point.  If port is zero a random port will be set
    tcp::endpoint myEndpoint(tcp::v4(), port);
    tcp::acceptor server(service, myEndpoint);  // create a server socket
    // Print information where the server is operating.    
    std::cout << "Listening for commands on port "
              << server.local_endpoint().port() << std::endl;
    // Check run tester client.
#ifdef TEST_CLIENT
    checkRunClient(argv[1]);
#endif

    // Run the server on the specified acceptor
    runServer(server);
    
    // All done.
    return 0;
}

// End of source code
