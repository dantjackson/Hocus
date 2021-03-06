
package com.stocker.rest;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.stocker.rest.SqlMySQLConn;
import com.stocker.rest.DataClasses.AddStock;
import com.stocker.rest.DataClasses.FolioStock;
import com.stocker.rest.DataClasses.StockByTime;
import com.stocker.rest.DataClasses.User;

public class FolioLoad {
	
	public static List<FolioStock> findFolioStockData(String userId) {
		
		List<FolioStock> list = new ArrayList<FolioStock>();
		Connection c = null;
		
//		String sql = "SELECT f.folio_id, f.folio_desc, f.folio_created_date, fs.stock_id, " + 
//				" fs.stock_qty, fs.stock_purchase_price, fs.stock_currency, u.user_id, " + 
//				" CONCAT(u.user_first_name,' ',u.user_last_name) user_name" +
//				" FROM hokus.folio f , hokus.user_folio uf , hokus.folio_stock fs, " + 
//				" hokus.hk_user u " + 
//				" WHERE u.user_id = " + userId + 
//				" AND u.user_id = uf.user_id " + 
//				" AND uf.folio_id = f.folio_id " +
//				" AND fs.folio_id = uf.folio_id ";
	   String sql = "CALL hokus.getFolio(" + userId + ")";
	//System.out.println(sql);
	
	try {
		c = SqlMySQLConn.getConnection();
		Statement s = c.createStatement();
		ResultSet rs = s.executeQuery(sql);
		while (rs.next()) {
			list.add(processStockDetail(rs));
		}
	} catch (SQLException e) {
		e.printStackTrace();
		throw new RuntimeException(e);
	} finally {
		SqlMySQLConn.close(c);
	}
	
	// Now add total Row to the Portfolio.
	FolioStock totalFolioStock = new FolioStock();
	totalFolioStock.setStockId("TOTAL");
	totalFolioStock.setFolioDesc("Total Portfolio Value");
	totalFolioStock.setStockName("Total For Portfolio");
	
	// Loop Existing Stock And Add Up Profit
	Double profitRunningTotal = 0.00;
	Double valueRunningTotal = 0.00;
	Double purchaseRunningTotal = 0.00;
	
	Iterator<FolioStock> iterator = list.iterator();
	while (iterator.hasNext()) {
		FolioStock x = iterator.next();
		profitRunningTotal = profitRunningTotal + 
						Double.parseDouble(x.getProfit());	
		valueRunningTotal = valueRunningTotal + 
				Double.parseDouble(x.getCurrentValue());	
		purchaseRunningTotal = purchaseRunningTotal + 
				Double.parseDouble(x.getPurchaseValue());	
		System.out.println(purchaseRunningTotal);
	}
	DecimalFormat df = new DecimalFormat("0.##");
	totalFolioStock.setProfit(df.format(profitRunningTotal));
	totalFolioStock.setCurrentValue(df.format(valueRunningTotal));
	totalFolioStock.setPurchaseValue(df.format(purchaseRunningTotal));

	list.add(totalFolioStock);
	
	return list;
		
	}
	
	protected static ArrayList<AddStock>  addStockToFolio(AddStock addStock) {

		ArrayList<AddStock> list = new ArrayList<AddStock>();
		Connection c = null;
		
		String sql = "CALL hokus.addStockToFolio(1,'" + addStock.getStockId() + "',"
						+ addStock.getStockPrice() + "," + addStock.getStockQty() + ")";
		System.out.println(sql);
		try {
			c = SqlMySQLConn.getConnection();
			Statement s = c.createStatement();
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				list.add(processStockToFolio(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			SqlMySQLConn.close(c);
		}
		
		return list;
		
	}
	
	protected static AddStock processStockToFolio(ResultSet rs) throws SQLException {
		AddStock dataresults = new AddStock();
		dataresults.setStockId(rs.getString("stockId"));
		dataresults.setStockMessage(rs.getString("stockMessage"));
		dataresults.setStockAdded(rs.getBoolean("stockAdded"));
		return dataresults;
	}
	
	protected static FolioStock processStockDetail(ResultSet rs)
			throws SQLException {
		
		FolioStock dataresults = new FolioStock();
		
		dataresults.setUserName(rs.getString("user_name"));
		dataresults.setUserId(rs.getInt("user_id"));
		dataresults.setFolioId(rs.getInt("folio_id"));
		dataresults.setFolioDesc(rs.getString("folio_desc"));
		dataresults.setFolioCreatedDate(rs.getDate("folio_created_date"));
		dataresults.setStockCurrency(rs.getString("stock_currency"));
		dataresults.setStockId(rs.getString("stock_id"));
		dataresults.setStockName(rs.getString("stock_name"));
		dataresults.setStockQty(rs.getDouble("stock_qty"));
		dataresults.setStockPurchasePrice(rs.getDouble("stock_purchase_price"));			
		
		dataresults.setEarningsShare(rs.getDouble("EarningsShare"));		
		dataresults.setBookValue(rs.getDouble("BookValue"));		
		dataresults.setYearHigh(rs.getDouble("YearHigh"));		
		dataresults.setYearLow(rs.getDouble("YearLow"));		
		dataresults.setChangeFromTwoHundreddayMovingAverage(rs.getDouble("ChangeFromTwoHundreddayMovingAverage"));		
		dataresults.setChangeFromFiftydayMovingAverage(rs.getDouble("ChangeFromFiftydayMovingAverage"));				
		dataresults.setStockBid(rs.getDouble("stock_bid"));		
		dataresults.setStockAsk(rs.getDouble("stock_ask"));				
		
	
		
		System.out.println("ERROR: "+rs.getString("stock_id"));
		
		return dataresults;
	}		

	
	protected static ArrayList<StockByTime>  findFolioPerfByTime(String userId) {

		ArrayList<StockByTime> list = new ArrayList<StockByTime>();
		Connection c = null;
		// Normalise Variables
		String currStock = "", prevStock = "", currDate = "";
		Double minBidVal=1000000.0, maxBidVal=0.0, curBidVal=0.0, prevBidVal = 0.0;
		Boolean normalise = true;
		int rowCount = 0;
		Map stockHighLowMap = new HashMap();
		
		String sql = "CALL hokus.getFolioStocksByTime(1)";
		
		try {
			c = SqlMySQLConn.getConnection();
			Statement s = c.createStatement();
			ResultSet rs = s.executeQuery(sql);
			
			// Normalise Option
			if (normalise) {
				while (rs.next()) {
					// Get High and Low Per Stock
					++rowCount;
					currStock = rs.getString("stock_id");
					curBidVal = rs.getDouble("stock_bid");
					if (prevStock.equals("")) {
						prevStock = currStock; 
					}
					
					if (currStock.equals(prevStock)) {  // Same stock new date
						if (curBidVal < minBidVal ) {
							minBidVal = curBidVal;
						}
						if (curBidVal > maxBidVal ) {
							maxBidVal = curBidVal;
						}						
					}
					else {  // New Stock
						// Save old stock info in Map
						// insert prevStock, minBidVal, maxBidVal
						stockHighLowMap.put(prevStock+"-Max",maxBidVal);
						stockHighLowMap.put(prevStock+"-Min",minBidVal);
						
						minBidVal = curBidVal;
						maxBidVal = curBidVal;
					}
					prevStock = currStock;
				}
				
				if (rowCount>1) {
				  stockHighLowMap.put(prevStock+"-Max",maxBidVal);
				  stockHighLowMap.put(prevStock+"-Min",minBidVal);
				}
				
				System.out.println(stockHighLowMap);
				rs.beforeFirst();
				
				while (rs.next()) {
					// Update bid values based on normalisation call.
					currStock = rs.getString("stock_id");
					prevBidVal = rs.getDouble("stock_bid");	
					currDate = rs.getString("f_stock_date");	
					//map = processFolioPerfByTime(rs));
					minBidVal = (Double) stockHighLowMap.get(currStock+"-Min");
					maxBidVal = (Double) stockHighLowMap.get(currStock+"-Max");		
					System.out.println("STOCK"+ currStock + "-"+prevBidVal+"-"+minBidVal+"-"+maxBidVal);
					curBidVal = normalise(prevBidVal, minBidVal, maxBidVal);
					System.out.println("LIST2");
					
					StockByTime dataresults = new StockByTime();
					dataresults.setStockId(currStock);
					dataresults.setStockBid(curBidVal);
					dataresults.setStockDate(currDate);
					list.add(dataresults);
				}	
				System.out.println("LIST");
				System.out.println(list);
			} // normalised processing
			
			if (!normalise) {
				rs.beforeFirst();
				while (rs.next()) {
					list.add(processFolioPerfByTime(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			SqlMySQLConn.close(c);
		}
		
		return list;
		
	}
	
	protected static StockByTime processFolioPerfByTime(ResultSet rs) throws SQLException {
		StockByTime dataresults = new StockByTime();
		dataresults.setStockId(rs.getString("stock_id"));
		dataresults.setStockBid(rs.getDouble("stock_bid"));
		dataresults.setStockDate(rs.getString("f_stock_date"));
		return dataresults;
	
	}
	
	public static double normalise(double inValue, double min, double max) {
      if (min==max) {
    	  return 0;
      }
      return (inValue - min)/(max - min);
	}
	
	

}
