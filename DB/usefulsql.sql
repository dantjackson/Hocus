DELIMITER ;;
CREATE PROCEDURE `getFolio`( userId INT )
BEGIN  

SELECT f.folio_id, f.folio_desc, f.folio_created_date, 
	s.stock_name, fs.stock_id, fs.stock_qty, fs.stock_purchase_price, fs.stock_currency, u.user_id, 
	CONCAT(u.user_first_name,' ',u.user_last_name) user_name,
    EarningsShare, BookValue, YearHigh, YearLow, ChangeFromTwoHundreddayMovingAverage,
	ChangeFromFiftydayMovingAverage, COALESCE(stock_bid,PreviousClose) stock_bid,
	COALESCE(stock_ask,PreviousClose) stock_ask
FROM hokus.folio f , hokus.user_folio uf , hokus.folio_stock fs, 
	hokus.hk_user u, hokus.stock_detail sd, hokus.stock s
WHERE u.user_id = userId 
AND u.user_id = uf.user_id 
AND uf.folio_id = f.folio_id 
AND fs.folio_id = uf.folio_id 
AND fs.stock_id = sd.stock_id
AND s.stock_id = fs.stock_id
AND sd.stock_date = current_date();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFolioStocksByTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `getFolioStocksByTime`(folioId INT)
BEGIN

  DECLARE stock_list TEXT;

  SELECT GROUP_CONCAT(stock_id SEPARATOR ',') as stock_id
  INTO stock_list
  FROM folio_stock
  WHERE folio_id = folioId;

  CALL getStockByTime(stock_list,'MONTH');
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getStockByTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `getStockByTime`(stockIdList TEXT, periodicty TEXT)
BEGIN

  IF periodicty = 'MONTH' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE FIND_IN_SET(stock_id, stockIdList) > 0
        AND stock_date >= (CURRENT_DATE() - INTERVAL 3 MONTH)
		ORDER BY stock_id, stock_date;
    END;
  END IF;
  
  IF periodicty = '6MONTH' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE
			FIND_IN_SET(stock_id, stockIdList) > 0
            
		ORDER BY stock_id, stock_date;
    END;
  END IF;
  
  IF periodicty = '1YEAR' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE
			FIND_IN_SET(stock_id, stockIdList) > 0
            
		ORDER BY stock_id, stock_date;
    END;
  END IF;  
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-23 14:25:55
