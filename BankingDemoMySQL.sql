use BankingDemo_dem;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema BankingDemo_dem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `valid_credit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `valid_credit` ;

CREATE TABLE IF NOT EXISTS `valid_credit` (
  `creditCode` SMALLINT(6) NOT NULL,
  `displayValue` VARCHAR(50) NULL DEFAULT NULL,
  `MaxCreditLimit` DECIMAL(10,2) NULL DEFAULT '1000.00',
  PRIMARY KEY (`creditCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `valid_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `valid_state` ;

CREATE TABLE IF NOT EXISTS `valid_state` (
  `stateCode` VARCHAR(2) NOT NULL,
  `stateName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`stateCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `CUSTOMER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUSTOMER` ;

CREATE TABLE IF NOT EXISTS `CUSTOMER` (
  `CustNum` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `CheckingAcctBal` DECIMAL(10,2) NULL DEFAULT 0,
  `SavingsAcctBal` DECIMAL(10,2) NULL DEFAULT 0,
  `TotalBalance` DECIMAL(10,2) NULL DEFAULT 0,
  `Street` VARCHAR(32) NULL DEFAULT NULL,
  `City` VARCHAR(24) NULL DEFAULT 'ORLANDO',
  `State` VARCHAR(2) NULL DEFAULT 'FL',
  `ZIP` INT(11) NULL DEFAULT '32751',
  `isActive` BIT(1) NULL DEFAULT b'1',
  PRIMARY KEY (`CustNum`),
  UNIQUE INDEX `U_Name_CUSTOMERS` (`Name` ASC),
  INDEX `fk_customers_valid_state1_idx` (`State` ASC),
 
  CONSTRAINT `fk_customers_valid_state`
    FOREIGN KEY (`State`)
    REFERENCES `valid_state` (`stateCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `CHECKING`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CHECKING` ;

CREATE TABLE IF NOT EXISTS `CHECKING` (
  `AcctNum` MEDIUMINT(9) NOT NULL ,
  `CustNum` MEDIUMINT(9) NOT NULL,
  `Deposits` DECIMAL(10,2) NULL DEFAULT 0,
  `Withdrawls` DECIMAL(10,2) NULL DEFAULT 0,
  `CurrentBalance` DECIMAL(10,2) NULL DEFAULT 0,
  `AvailableBalance` DECIMAL(10,2) NULL DEFAULT 0,
  `ItemCount` MEDIUMINT(9) NOT NULL DEFAULT 0,
  `CreditCode` SMALLINT(6) NULL DEFAULT NULL,
  `CreditLimit` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`AcctNum`,`CustNum`),
  INDEX `U_Name_CHKG_CUST` (`CustNum` ASC),
  INDEX `fk_cchecking_valid_credit1_idx` (`CreditCode` ASC),
  CONSTRAINT `fk_checking_valid_credit1`
    FOREIGN KEY (`CreditCode`)
    REFERENCES `valid_credit` (`creditCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHECKING_CUSTOMER1`
    FOREIGN KEY (`CustNum`)
    REFERENCES `CUSTOMER` (`CustNum`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `CHECKING_TRANS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CHECKING_TRANS` ;

CREATE TABLE IF NOT EXISTS `CHECKING_TRANS` (
  `TransId` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `AcctNum` MEDIUMINT(9) NOT NULL,
  `CustNum` MEDIUMINT(9) NOT NULL,
  `TransDate` DATETIME NULL DEFAULT NULL,
  `DepositAmt` DECIMAL(10,2) NULL DEFAULT 0,
  `WithdrawlAmt` DECIMAL(10,2) NULL DEFAULT 0,
  `Total` DECIMAL(10,2) NULL DEFAULT 0,
  `PendingFlag` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`TransId`),
  INDEX `U_Name_CHKG_CUST` (`AcctNum` ASC, `CustNum` ASC),
  CONSTRAINT `fk_CHECKING_TRANS_CHECKING1`
    FOREIGN KEY (`AcctNum` , `CustNum`)
    REFERENCES `CHECKING` (`AcctNum` , `CustNum`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SAVINGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAVINGS` ;

CREATE TABLE IF NOT EXISTS `SAVINGS` (
  `AcctNum` MEDIUMINT(9) NOT NULL,
  `CustNum` MEDIUMINT(9) NOT NULL,
  `Deposits` DECIMAL(10,2) NULL DEFAULT 0,
  `Withdrawls` DECIMAL(10,2) NULL DEFAULT 0,
  `CurrentBalance` DECIMAL(10,2) NULL DEFAULT 0,
  `AvailableBalance` DECIMAL(10,2) NULL DEFAULT 0,
  `ItemCount` MEDIUMINT(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AcctNum`,`CustNum`),
  INDEX `U_Name_CHKG_CUST` (`CustNum` ASC),
  CONSTRAINT `fk_SAVINGS_CUSTOMER1`
    FOREIGN KEY (`CustNum`)
    REFERENCES `CUSTOMER` (`CustNum`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SAVINGS_TRANS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAVINGS_TRANS` ;

CREATE TABLE IF NOT EXISTS `SAVINGS_TRANS` (
  `TransId` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `AcctNum` MEDIUMINT(9) NOT NULL,
  `CustNum` MEDIUMINT(9) NOT NULL,
  `TransDate` DATETIME NULL DEFAULT NULL,
  `DepositAmt` DECIMAL(10,2) NULL DEFAULT 0,
  `WithdrawlAmt` DECIMAL(10,2) NULL DEFAULT 0,
  `Total` DECIMAL(10,2) NULL DEFAULT 0,
  `PendingFlag` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`TransId`),
  INDEX `U_Name_CHKG_CUST` (`AcctNum` ASC, `CustNum` ASC),
  CONSTRAINT `fk_SAVINGS_TRANS_SAVINGS1`
    FOREIGN KEY (`AcctNum` , `CustNum`)
    REFERENCES `SAVINGS` (`AcctNum` , `CustNum`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TRANSFR_FUNDS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TRANSFR_FUNDS` ;

CREATE TABLE IF NOT EXISTS `TRANSFR_FUNDS` (
  `TransId` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `FromAcct` MEDIUMINT(9) NOT NULL,
  `FromCustNum` MEDIUMINT(9) NOT NULL,
  `ToAcct` MEDIUMINT(9) NOT NULL,
  `ToCustNum` MEDIUMINT(9) NOT NULL,
  `TransferAmt` DECIMAL(10,2) NULL DEFAULT 0,
  `TransDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`TransId`),
  INDEX `fk_TRANSFR_FUNDS_CUSTOMER1_idx` (`FromCustNum` ASC),
  INDEX `fk_TRANSFR_FUNDS_CUSTOMER2_idx` (`ToCustNum` ASC),
  CONSTRAINT `fk_TRANSFR_FUNDS_CUSTOMER1`
    FOREIGN KEY (`FromCustNum`)
    REFERENCES `CUSTOMER` (`CustNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRANSFR_FUNDS_CUSTOMER2`
    FOREIGN KEY (`ToCustNum`)
    REFERENCES `CUSTOMER` (`CustNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Data for table `valid_state`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('AK', 'Alaska');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('AL', 'Alabama');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('AR', 'Arkansas');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('AZ', 'Arizona');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('CA', 'California');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('CO', 'Colorado');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('CT', 'Connecticut');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('DE', 'Delaware');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('FL', 'Florida');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('GA', 'Georgia');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('HI', 'Hawaii');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('IA', 'Iowa');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('ID', 'Idaho');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('IL', 'Illinois');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('IN', 'Indiana');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('KS', 'Kansas');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('KY', 'Kentucky');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('LA', 'Louisiana');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MA', 'Massachusetts');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MD', 'Maryland');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('ME', 'Maine');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MI', 'Michigan');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MN', 'Minnesota');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MO', 'Missouri');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MS', 'Mississippi');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('MT', 'Montana');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NC', 'North Carolina');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('ND', 'North Dakota');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NE', 'Nebraska');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NH', 'New Hampshire');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NJ', 'New Jersey');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NM', 'New Mexico');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NV', 'Nevada');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('NY', 'NewYork');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('OH', 'Ohio');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('OK', 'Oklahoma');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('OR', 'Oregon');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('PA', 'Pennsylvania');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('RI', 'Rhode Island');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('SC', 'South Carolina');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('SD', 'South Dakota');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('TN', 'Tennessee');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('TX', 'Texas');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('UT', 'Utah');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('VA', 'Virginia');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('VT', 'Vermont');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('WA', 'Washington');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('WI', 'Wisconsin');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('WV', 'West Virginia');
INSERT INTO `valid_state` (`stateCode`, `stateName`) VALUES ('WY', 'Wyoming');

COMMIT;

-- -----------------------------------------------------
-- Data for table `valid_credit`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO `valid_credit` (`creditCode`, `displayValue`, `MaxCreditLimit`) VALUES (1, 'Excellent', 5000);
INSERT INTO `valid_credit` (`creditCode`, `displayValue`, `MaxCreditLimit`) VALUES (2, 'Good', 1000);
INSERT INTO `valid_credit` (`creditCode`, `displayValue`, `MaxCreditLimit`) VALUES (3, 'Fair', 500);
INSERT INTO `valid_credit` (`creditCode`, `displayValue`, `MaxCreditLimit`) VALUES (4, 'Poor', 250);
INSERT INTO `valid_credit` (`creditCode`, `displayValue`, `MaxCreditLimit`) VALUES (5, 'No Credit', 0);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
