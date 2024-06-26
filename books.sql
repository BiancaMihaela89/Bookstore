#1.DDL (Data Definition Language)
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

#Afiseaza tabela
SELECT * FROM Subscription;

#Descrie structura unui tabel
DESC Subscription;

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

#2.DML (Data Manipulation Language)

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

#Update pentru a actualiza statusul comenzii cu ID-ul 1
UPDATE Orders SET Status_Orders = 'delivered' WHERE ID = 1;
 
#Update pentru a actualiza cantitatea comenzii cu Id-ul =3
UPDATE Orders SET Quantity = 5 WHERE ID = 3;
 
#Update pentru a actualiza prenumele clientului cu Id-ul =3
UPDATE Customers SET First_Name = 'Mihaita' where ID = 2;
 
 
#3.DQL (Data Query Language)

#Delete pentru a elimina abonamentele care au expirat
DELETE FROM Customer_Subscription WHERE End_Date < CURDATE();

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

# Afisare ce carti exista in afara de Poezii
SELECT * FROM Books WHERE Title != 'Poezii';

#Afisare numele de familie al clientului, cantitatea de carti comandate si daca au abonament VIP
SELECT Customers.Last_Name, Orders.Quantity, Customer_Subscription.VIP
FROM Customers INNER JOIN Orders INNER JOIN Customer_Subscription
ON Customers.ID=Orders.Customer_id AND Customers.ID=Customer_Subscription.Customer_Id;

#Afisare informatii despre comenzi si clienti folosind INNER JOIN
SELECT Orders.ID, Orders.Status_Orders, Customers.First_Name, Customers.Last_Name
FROM Orders
INNER JOIN Customers 
ON Orders.Customer_id = Customers.ID;

# Afisare informatii folosind left join
SELECT Orders.Books_ordered, Customers.First_Name, Customers.Phone_number
FROM Orders LEFT JOIN Customers
ON Orders.Customer_id = Customers.ID;

# Afisare informatii folosind right join
SELECT Customer_Subscription.VIP, Customers.Last_Name, Customers.Phone_number
FROM Customer_Subscription RIGHT JOIN Customers
ON Customer_Subscription.Customer_id = Customers.ID;

#Functii Agregate
#Calcularea sumei totale a preturilor pentru toate comenzile
SELECT SUM(Price * Quantity) AS Total_Price FROM Books
INNER JOIN Orders ON Books.ID = Orders.Customer_id;

#Afisare numar total de carti al caror pret este mai mare ca 7 in tabela Books
SELECT COUNT(*) FROM Books WHERE Price > 7;

#Afisarea anului celei mai recente cărți din tabela Books
SELECT MAX(ReleaseYear) FROM Books;

#Afisarea prețului mediu al cărților din tabela Books
SELECT AVG(Price) FROM Books;

#Afisarea cărților după autor și prețul mediu al cărților pentru fiecare autor.
SELECT Author, AVG(Price) 
FROM Books
GROUP BY Author;

#Afisarea clientii care au comandat cel putin 2 carti
SELECT Customers.First_Name, Customers.Last_Name
FROM Customers
JOIN Orders ON Customers.ID = Orders.Customer_id
GROUP BY Customers.ID
HAVING COUNT(Orders.ID) >= 2;

#Afisarea comenzilor care au o valoare totala mai mare de 20
SELECT * FROM Orders
WHERE Quantity * (SELECT Price FROM Books WHERE Books.ID = Orders.Customer_id) > 20;

#Afisarea comenzilor care au un client VIP
SELECT * FROM Orders
INNER JOIN Customer_Subscription ON Orders.Customer_id = Customer_Subscription.Customer_id
WHERE Customer_Subscription.VIP = true;

#Afisarea clientilor care au comenzi în așteptare.
SELECT *
FROM Customers
WHERE ID IN (SELECT Customer_id FROM Orders WHERE Status_Orders = 'pending');










