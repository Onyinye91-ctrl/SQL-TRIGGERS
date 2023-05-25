
-- WORKING WITH TRIGGERS

-- use database projects
USE projects;

-- create table Products
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);

-- insert values in the table Products
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)
VALUES ("P1", "Artificial grass bags ", 40, 50, 100),  
("P2", "Wood panels", 15, 20, 250),  
("P3", "Patio slates",35, 40, 60),  
("P4", "Sycamore trees ", 7, 10, 50),  
("P5", "Trees and Shrubs", 35, 50, 75),  
("P6", "Water fountain", 65, 80, 15);

-- Create another table Notifications
CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID));

-- TASK 1
-- Create an INSERT trigger called ProductSellPriceInsertCheck. This trigger must check if the SellPrice of the product is less than
-- the BuyPrice after a new product is inserted in the Products table.

DELIMITER //

CREATE TRIGGER ProductSellPriceInsertCheck 
    AFTER INSERT  
    ON Products FOR EACH ROW  
	BEGIN
	IF NEW.SellPrice <= NEW.BuyPrice THEN
		INSERT INTO Notifications(Notification,DateTime) 
		VALUES(CONCAT('A SellPrice same or less than the BuyPrice was inserted for ProductID ', NEW.ProductID), NOW()); 
    END IF;
	END;
    
DELIMITER ;



-- TASK 2
-- Create an UPDATE trigger called ProductSellPriceUpdateCheck. This trigger must check that products are not updated
-- with a SellPrice that is less than or equal to the BuyPrice. The notification message should be in the following format:
-- 'ProductID + was updated with a SellPrice of  + SellPrice + which is the same or less than the BuyPrice'

DELIMITER //

CREATE TRIGGER ProductSellPriceUpdateCheck 
    AFTER UPDATE  
    ON Products FOR EACH ROW  
	BEGIN
	IF NEW.SellPrice <= NEW.BuyPrice THEN
		INSERT INTO Notifications(Notification,DateTime) 
		VALUES(CONCAT(NEW.ProductID,' was updated with a SellPrice of ', NEW.SellPrice,' which is the same or less than the BuyPrice'), NOW()); 
    END IF;
	END;

DELIMITER;



-- TASK 3
-- Create a DELETE trigger called NotifyProductDelete. This trigger must insert a notification in the Notifications table for the sales
-- department after a product has been deleted from the Products table. The notification message should be in the following format:
-- 'The product with a ProductID  + ProductID + was deleted'

DELIMITER //

CREATE TRIGGER NotifyProductDelete 
    AFTER DELETE   
    ON Products FOR EACH ROW   
	INSERT INTO Notifications(Notification, DateTime) 
    VALUES(CONCAT('The product with a ProductID ', OLD.ProductID,' was deleted'), NOW()); 

DELIMITER ;








