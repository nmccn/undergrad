// **************************************************************************************
// * Basic HTTP Server (web_server.cc)
// * -- Receive & Process Basic HTTP Requests.
// * -- Written by: Nicholas McClellan, using Dr. Romig starter code from P1. Oct-2020
// **************************************************************************************
#include "web_server.h"
int processConnection(int fd);
// **************************************************************************************
// * main()
// * - Sets up the sockets and accepts new connection until processConnection() returns 1
// **************************************************************************************

int main (int argc, char *argv[]) {
  // ************************************************************************************
  // * Process the command line arguments
  // ********************************************************************
  int opt = 0;
  while ((opt = getopt(argc,argv,"v")) != -1) {

    switch (opt) {
    case 'v':
      break;
    case ':':
    case '?':
    default:
      std::cout << "useage: " << argv[0] << " -v" << std::endl;
      exit(-1);
    }
  }

  // *******************************************************************
  // * Creating the inital socket is the same as in a client.
  // ********************************************************************
  int listenFd = -1;
  // Call socket() to create the socket you will use for lisening.
	listenFd = socket(AF_INET, SOCK_STREAM, 0);
  printf("Calling Socket() on the assigned file descriptor %d\n", listenFd);

  // ********************************************************************
  // * The bind() and calls take a structure that specifies the
  // * address to be used for the connection. On the cient it contains
  // * the address of the server to connect to. On the server it specifies
  // * which IP address and port to lisen for connections.
  // ********************************************************************
  struct sockaddr_in servaddr;
  srand(time(NULL));
  int port = (rand() % 10000) + 1024;
  bzero(&servaddr, sizeof(servaddr));
  //Still unsure why the PF_INET here and AF_INET above aren't matching, but alas.
  servaddr.sin_family = PF_INET;
  servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  servaddr.sin_port = htons(port);

  // ********************************************************************
  // * Binding configures the socket with the parameters we have
  // * specified in the servaddr structure.  This step is implicit in
  // * the connect() call, but must be explicitly listed for servers.
  // ********************************************************************
  printf("Calling bind()\n");
 
  int bindState = bind(listenFd, (struct sockaddr *)&servaddr, sizeof(servaddr));
  
  while (bindState != 0) {
    // You may have to call bind multiple times if another process is already using the port
    // your program selects.
	bindState = bind(listenFd, (struct sockaddr *)&servaddr, sizeof(servaddr));
  }	
  printf("Using port : %d\n", port);

  // ********************************************************************
  // * Setting the socket to the listening state is the second step
  // * needed to being accepting connections.  This creates a queue for
  // * connections and starts the kernel listening for connections.
  // ********************************************************************
  //Not sure if this is needed anymore, going to set the length = 1.
  int listenQueueLength = 1;
  printf("Calling listen(%d, %d)\n", listenFd, listenQueueLength);
  // DEBUG << "Calling listen(" << listenFd << "," << listenQueueLength << ")" << ENDL;
  listen(listenFd, listenQueueLength);
 

  // ********************************************************************
  // * The accept call will sleep, waiting for a connection.  When 
  // * a connection request comes in the accept() call creates a NEW
  // * socket with a new fd that will be used for the communication.
  // ********************************************************************
  int quitProgram = 0;
  while (!quitProgram) {
    int connFd = 0;

    printf("Calling accept(%d, NULL, NULL)\n", listenFd);

    // The accept() call checks the listening queue for connection requests.
    // If a client has already tried to connect accept() will complete the
    // connection and return a file descriptor that you can read from and
    // write to. If there is no connection waiting accept() will block and
    // not return until there is a connection
    
    connFd = accept(listenFd, NULL, NULL);
    printf("We have received a connection on: %d\n",connFd);
    quitProgram = processConnection(connFd);
    close(connFd);
  }

  close(listenFd);

}

// **************************************************************************************
// * processConnection()
// * - Handles reading the line from the network and sending it back to the client.
// * - Returns 1 if the client sends "QUIT" command, 0 if the client sends "CLOSE".
// **************************************************************************************
int processConnection(int connFd) {
  // ************************************************************************************
  // * Formats for the Responses, 200-OK, 400-BADREQUEST, and 404-FILENOTFOUND
  // * ALL FORMATS SAME BUT WITH DIFFERENT HEADER, NOT ENTIRELY SURE IF CORRECT
  // ************************************************************************************
  char ok[] = 
    "HTTP/1.0 200 OK\r\n"
    "Content-Type: text/html; charset=UTF-8\r\n"
    "Content-Encoding: UTF-8\r\n";
  
  char badreq[] =
    "HTTP/1.0 400 Bad Request\r\n"
    "Content-Type: text/html; charset=UTF-8\r\n"
    "Content-Encoding: UTF-8\r\n";
  
  char notfound[] = 
    "HTTP/1.0 404 Not Found\r\n"
    "Content-Type: text/html; charset=UTF-8\r\n"
    "Content-Encoding: UTF-8\r\n";

  char okImage[] = 
    "HTTP/1.0 200 OK\r\n"
    "Content-Type: image/jpeg\r\n";

  //to limit how much of the file we read/write?
  const int MAX = 81920;
  int quitProgram = 0;
  int keepGoing = 1;
  uint8_t rcvbuf[MAX+1] = {0};
  //info to be filled after parsing the request.
  char* method;
  char* url;
  int byte = 0;
  //for stat() ie. help get size of file
  struct stat filestat;
  int file_buff[MAX];


  bzero(rcvbuf, sizeof(rcvbuf));

  printf("Waiting to receive GET request on socket: %d\n", connFd);
  while (keepGoing) {

    //
    // Call read() call to get a buffer/line from the client.
    // Hint - don't forget to zero out the buffer each time you use it.
    // 
    //if the 'index' is subzero, we know there was an issue reading (read returns -1) thus we will exit gracefully
    if((byte = read(connFd, rcvbuf, MAX-1)) < 0){
      printf("ERROR during read()\n");
      return 1;
    }

    //simple print of the request, found in rcvbuf
    printf("\n\n");
    printf("Printing the GET request:\n");
    printf("%s", (char*)rcvbuf);

    //Parse the request (oh boy!) rcvbuf is going to have the entire request. We just need to find GET
    //Use strtok() to capture only the first line (using \r\n as a deleimiter)
    char* requestLine = strtok((char*)rcvbuf, "\r\n");
    printf("LINE: %s\n", requestLine);
    //now we have some line method path/to_file/ HTTP 1.0 \r\n , we really only need the first 2 tokens?, could I not
    //just use strtok again and iterate once?
    char* token = strtok(requestLine, " ");
    //get method & URL
    method = token;
    printf("METHOD: %s\n", method);
    token = strtok(NULL, " ");
    url = token;
    printf("URL: %s\n", url);
    
    //If there is not a file provided. 
    if(strcmp(url, "") == 0){
      printf("%s\n\n", ok);
      write(connFd, &ok, sizeof(ok));
      write(connFd, "No File Requested", sizeof("No File Requested"));\
      close(connFd);
      return 0;
    }
    //Or a file is provided
    else{
      //Need to create the response, add the file requested, and then send it back
      FILE *fptr;
      //take off the / from url, little pointer arithmetic for the boys
      char* shortenedURL = url + 1;
      printf("NEW URL: %s\n\n", shortenedURL);
      //int filefd = open(shortenedURL, O_RDONLY);
      fptr = fopen((char*)shortenedURL, "rb");
      //If the file isn't found
      if(fptr == NULL){
          //AND the request isn't a GET request
          if(strcmp(method, "GET") != 0){
            printf("%s\n\n", badreq);
            write(connFd, &badreq, sizeof(badreq));
            write(connFd, "Bad Request", sizeof("Bad Request"));
             close(connFd);
            return 0;
          }
          //OR the file isn't found
          else{
            printf("%s\n\n", notfound);
            write(connFd, &notfound, sizeof(notfound));
            write(connFd, "File Not Found", sizeof("File Not Found"));
            close(connFd);
            return 0;
          }
      }
      //Otheriwse, the request is valid GET, and the file is provided
      else{
          //for content length header
          char clHeader[40] = "Content-Length: ";
          //for the size of file
          fseek(fptr, 0, SEEK_END);
          int fSize = ftell(fptr);
          rewind(fptr);
          //If the file is html
          if(strstr(shortenedURL, ".html")){
            //send header - length            
            printf("%s\n\n", ok);
            write(connFd, &ok, sizeof(ok));
            //create + send length line

          }
          //If the file is a jpeg
          if(strstr(shortenedURL, ".jpg") || strstr(shortenedURL, ".jpeg")){   
            //send header - length    
            printf("%s\n\n", okImage);
            write(connFd, &okImage, sizeof(okImage));
            //create + send length line
            sprintf(clHeader+strlen(clHeader), "%d", fSize);
            strcat(clHeader, "\r\n\r\n");
            printf("%s\n\n", clHeader);
            write(connFd, clHeader, strlen(clHeader));

          }
          //Read and Write
          fread(file_buff, sizeof(int), fSize, fptr);
          fclose(fptr);
          write(connFd, file_buff, fSize);

          close(connFd);
          return 0;
      }
    }
  }
  close(connFd);
  return 0;
}

