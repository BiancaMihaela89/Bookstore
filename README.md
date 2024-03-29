<h1>Database Project for **Bookstore**</h1>

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Tools used: MySQL Workbench

Database description: 
The Bookstore database is designed to manage the operations of a bookstore, including inventory, customer information, orders, and subscriptions. It serves as a central repository for storing and organizing data related to books, customers, their orders, and subscription details. The database stores essential information such as book titles, authors, publication years, customer names, contact details, order details, and subscription durations. With this database, bookstore administrators can effectively manage their inventory, track customer orders, and monitor subscription services.


<ol>
<li>Database Schema </li>
<br>

| Books | Customers   | Orders| Customer_Subscription |
| :-----: | :---: | :---:  |:---: |
| PK ID | PK ID |      PK ID            |PK ID|
| Author| FK Books_id |FK Customer_id |Start_Date|
| Title| First_Name | Books_ordered|End_Date|
| Type_Books| Last_Name | Quantity |FK Custormer_Id|
| ReleaseYear| Phone_number|  Status_Orders |   VIP    |
| Price|    |      |    |

  
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.


![EEG Diagram](https://github.com/BiancaMihaela89/Bookstore/assets/149070909/4ed239df-0f74-4277-aef7-a07a1b5e6554)

The tables are connected in the following way:

<ul>
  <li> **Books**  is connected with **Customers** through a **one-to-many** relationship which was implemented through **Books.ID** as a primary key and **Customers.Books_id** as a foreign key</li>
  <li> **Orders**  is connected with **Customers** through a **one-to-many** relationship which was implemented through **Customers.ID** as a primary key and **Orders.Customer_id** as a foreign key</li>
  <li> **Customers**  is connected with **Customer_Subscriptions** through a **one-to-many** relationship which was implemented through **Customers.ID** as a primary key and **Customer_Subscriptions.Custoer_Id** as a foreign key</li>
</ul><br>

<li>Database Queries</li><br>

<ol type="a">
  <li>DDL (Data Definition Language)</li>

  The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)

       #Creare baza de date
        CREATE DATABASE  Bookstore;

        #Folosirea bazei de date create
         USE Bookstore;

        #Creare tabela pentru informatii despre carti  
         CREATE TABLE  Books (
         ID INT AUTO_INCREMENT PRIMARY KEY,
         Author VARCHAR(100),
         Title VARCHAR(100),
         Type_Books VARCHAR(100)
         );

       #Creare tabela pentru informatii despre clienti  
        CREATE TABLE Customers (
        ID INT AUTO_INCREMENT PRIMARY KEY,
        Book_id INT,
        First_Name VARCHAR(100),
        Last_Name VARCHAR(100),
        Phone VARCHAR(10),
        FOREIGN KEY (Book_id) REFERENCES Books(ID)
        );

       #Creare tabela pentru informatii despre comenzi
        CREATE TABLE Orders (
        ID INT AUTO_INCREMENT PRIMARY KEY,
        Customer_id INT,
        Books_ordered VARCHAR(100),
        Quantity INT,
        Status_Orders VARCHAR(50),
        FOREIGN KEY (Customer_id) REFERENCES Customers(ID)
        );

      #Creare tabela pentru informatii despre abonamente
       CREATE TABLE  Subscription (
       ID INT AUTO_INCREMENT PRIMARY KEY,
       Start_Date DATE,
       End_Date DATE,
       Customer_Id INT,
       FOREIGN KEY (Customer_id) REFERENCES Customers(ID)
       );

  After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:

       #Instructiuni ALTER

       #Adaugam coloane
        ALTER TABLE Subscription ADD COLUMN VIP bool;
        ALTER TABLE Books ADD COLUMN Release_Year int;

       #Schimbare nume coloanei "Release_Year" in "ReleaseYear" in tabela Books
        ALTER TABLE Books CHANGE COLUMN Release_Year  ReleaseYear INT;

       #Adaugare coloana "Price" de tip DECIMAL in tabela Books
        ALTER TABLE Books ADD COLUMN Price DECIMAL(10,2);

       #Stergere coloana "Type_Books" din tabela Books
        ALTER TABLE Books DROP COLUMN Type_Books;

       #Redenumirea coloanei "Phone" in "Phone_number" in tabela Customers si modificarea tipului de date
        ALTER TABLE Customers CHANGE COLUMN Phone Phone_number int;

       #Modificarea  coloanei "Title" in tabela Books, va fi VARCHAR (255)
        ALTER TABLE Books MODIFY Title VARCHAR (255);

       #Redenumirea unei tabele
        ALTER TABLE Subscription RENAME TO Customer_Subscription;
 
  
  <li>DML (Data Manipulation Language)</li>

  In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data. 
  In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase. 

  Below you can find all the insert instructions that were created in the scope of this project:
       
       #Inserare date in tabela Books folosind insert pe toate coloanele
        INSERT INTO Books (Author, Title, ReleaseYear, Price) VALUES
        ('Ion Creanga', 'Amintiri din Copilarie',1999, 10),
        ('Mircea Eliade', 'Maitreyi', 2000, 20),
        ('Mihai Eminescu', 'Poezii',2005, 5);

      #Inserare date in tabela Customers folosind insert pe toate coloanele
       SELECT * FROM Customers;
       INSERT INTO Customers (Book_id, First_Name, Last_Name, Phone_number) VALUES
       (1,'Ion', 'Popescu', 0712345678),
       (2,'Mihai', 'Ionescu', 0712345687),
       (3,'Ana', 'Iliescu', 0712345612);

      #Inserare date in tabela Orders folosind insert pe toate coloanele
       SELECT * FROM Orders;
       INSERT INTO Orders (Customer_id, Books_ordered, Quantity, Status_Orders) VALUES
       (1, 'Amintiri din Copilarie', 2, 'pending'),
       (2, 'Maitreyi', 1, 'shipped'),
       (3, 'Poezii', 3, 'delivered');

      #Inserare date in tabela Customer_Subscription folosind insert pe toate coloanele
       SELECT * FROM  Customer_Subscription;
       INSERT INTO Customer_Subscription (Start_Date, End_Date, Customer_id, VIP) VALUES
       ('2023-01-01', '2023-12-31', 2, true),
       ('2022-01-01', '2022-12-31', 1, false),
       ('2024-01-01', '2024-03-01', 3, true);

      #Inserare date in tabela Customers folosind insert pe cateva coloane
       INSERT INTO Customers (First_Name, Last_Name, Phone_number) VALUES 
       ('Alina', 'Adamescu', 0712345679),
       ('Ilie', 'Popoviciu', 0712345680);
       SELECT * FROM Customers;

      #Inserare mai multe randuri in tabela Orders
       INSERT INTO Orders (Customer_id, Books_ordered, Quantity, Status_Orders) VALUES 
       (1, '1984', 2, 'shipped'),
       (2, 'Crima si pedeaspsa', 1, 'pending');
       SELECT * FROM Orders;
  
  After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:

      #Update pentru a actualiza statusul comenzii cu ID-ul 1
       UPDATE Orders SET Status_Orders = 'delivered' WHERE ID = 1;
 
      #Update pentru a actualiza cantitatea comenzii cu Id-ul =3
       UPDATE Orders SET Quantity = 5 WHERE ID = 3;
 
      #Update pentru a actualiza prenumele clientului cu Id-ul =3
       UPDATE Customers SET First_Name = 'Mihaita' where ID = 2;


  <li>DQL (Data Query Language)</li>

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean: 

      #Delete pentru a elimina abonamentele care au expirat
       DELETE FROM Customer_Subscription WHERE End_Date < CURDATE();

In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

      #Afisare informatii despre carti care au un titlu care incepe cu litera 'A'
       SELECT * FROM Books WHERE Title LIKE 'A%';

      #Afisare carti  folosind paranteze sa prioritizam
       SELECT * FROM Books;
       SELECT * FROM Books
       WHERE (Author LIKE 'Mihai Eminescu'
       OR Title LIKE 'Poezii' )
       AND Price > 2;

     #Afisare clienti care nu au abonament VIP
      INSERT INTO Customer_Subscription (Customer_id, VIP) VALUES
      (4, true),
      (5, false);
      SELECT * FROM Customers
      WHERE ID NOT IN (SELECT Customer_Id FROM Customer_Subscription WHERE VIP = true);

     #Afisare informatii despre clienti care au un nume de familie Popescu
      SELECT * FROM Customers WHERE Last_Name = 'Popescu';

     #Afisare ce carti exista in afara de Poezii
      SELECT * FROM Books WHERE Title != 'Poezii';

     #Afisare numele de familie al clientului, cantitatea de carti comandate si daca au abonament VIP
      SELECT Customers.Last_Name, Orders.Quantity, Customer_Subscription.VIP
      FROM Customers INNER JOIN Orders inner join Customer_Subscription
      ON Customers.ID=Orders.Customer_id and Customers.ID=Customer_Subscription.Customer_Id;

     #Afisare informatii despre comenzi si clienti folosind INNER JOIN
      SELECT Orders.ID, Orders.Status_Orders, Customers.First_Name, Customers.Last_Name
      FROM Orders
      INNER JOIN Customers 
      ON Orders.Customer_id = Customers.ID;

     #Afisare informatii folosind left join
      SELECT Orders.Books_ordered, Customers.First_Name, Customers.Phone_number
      FROM Orders LEFT JOIN Customers
      ON Orders.Customer_id = Customers.ID;

     #Afisare informatii folosind right join
      SELECT Customer_Subscription.VIP, Customers.Last_Name, Customers.Phone_number
      FROM Customer_Subscription RIGHT JOIN Customers
      ON Customer_Subscription.Customer_id = Customers.ID;

     #Functii Agregate
     #Calcularea sumei totale a preturilor pentru toate comenzile
      SELECT SUM(Price * Quantity) AS Total_Price FROM Books
      INNER JOIN Orders ON Books.ID = Orders.Customer_id;

     #Afisare numar total de carti al caror pret este mai mare ca 7 in tabela Books
      SELECT COUNT(*) from Books where Price > 7;

     #Afisarea anului celei mai recente cărți din tabela Books
      SELECT MAX(ReleaseYear) FROM Books;

     #Afisarea prețului mediu al cărților din tabela Books
      SELECT AVG(Price) FROM Books;

     #Afisarea cărților după autor și va calcula prețul mediu al cărților pentru fiecare autor.
      SELECT Author, AVG(Price) 
      FROM Books
      GROUP BY Author;

     #Afisarea clienților care au plasat între 1 și 5 comenzi.
      SELECT Customer_id, COUNT(*) AS Total_Orders
      FROM Orders
      GROUP BY Customer_id
      HAVING Total_Orders BETWEEN 1 AND 5;

    #Afisarea comenzilor care au o valoare totala mai mare de 20
     SELECT * FROM Orders
     WHERE Quantity * (SELECT Price FROM Books WHERE Books.ID = Orders.Customer_id) > 20;

    #Afisarea comenzilor care au un client VIP
     SELECT * FROM Orders
     INNER JOIN Customer_Subscription ON Orders.Customer_id = Customer_Subscription.Customer_id
     WHERE Customer_Subscription.VIP = true;

    #Afisarea clientilor care au comenzi în așteptare.
     SELECT * FROM Customers
     WHERE ID IN (SELECT Customer_id FROM Orders WHERE Status_Orders = 'pending');

</ol>

<li>**Conclusions**</li>

Through this database project for a **Bookstore**, I have applied various SQL concepts and gained practical knowledge about creating, modifying, and querying databases. I have learned to use statements such as CREATE, ALTER, INSERT, UPDATE, DELETE, and SELECT to manipulate data and extract relevant information. Additionally, I have understood the importance of relationships between tables and explored different methods to perform complex queries to address various business requirements. This project has helped me consolidate my practical skills in SQL and better understand how databases are used in software development.

</ol>
