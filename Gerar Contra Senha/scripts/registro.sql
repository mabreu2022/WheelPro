CREATE TABLE fred.registro (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_chave INT(11) DEFAULT NULL,
  chave VARCHAR(200) DEFAULT NULL,
  data_inc DATE DEFAULT NULL,
  data_exp DATE DEFAULT NULL,
  contrasenha VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci;