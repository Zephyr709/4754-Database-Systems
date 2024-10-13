CREATE TABLE Video (
    CatalogID INT AUTO_INCREMENT NOT NULL, 
    VideoID INT NOT null,
    Title VARCHAR(100) not null,
    `Status` ENUM('available','rented') not NULL,
    DailyRentalFee FLOAT not null,
    CategoryName enum('Action','Adult','Children','Drama','Horror','Sci-Fi') not null,
    PRIMARY KEY (CatalogID,VideoID)
);

create TABLE Rental (
    CatalogID INT NOT NULL,
    VideoID INT NOT NULL,
    CustomerID INT NOT NULL,

)
