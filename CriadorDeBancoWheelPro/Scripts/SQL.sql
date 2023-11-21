CREATE DATABASE `fred` /*!40100 DEFAULT CHARACTER SET latin1 */;

CREATE TABLE `clientes` (
  `idclientes` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(14) DEFAULT NULL,
  `cnpj_raiz` varchar(8) DEFAULT NULL,
  `filial_numero` int(11) DEFAULT NULL,
  `razao_social` varchar(100) DEFAULT NULL,
  `nome_fantasia` varchar(100) DEFAULT NULL,
  `data_abertura` varchar(45) DEFAULT NULL,
  `situacao_cadastral` varchar(25) DEFAULT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` varchar(5) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `cnpj_mei` varchar(1) DEFAULT NULL,
  `versao` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`idclientes`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
