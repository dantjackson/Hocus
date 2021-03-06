package com.get;

// https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
	
// https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class StockReadYahooJSON {

  private static String readAll(Reader rd) throws IOException {
    StringBuilder sb = new StringBuilder();
    int cp;
    while ((cp = rd.read()) != -1) {
      sb.append((char) cp);
    }
    return sb.toString();
  }

  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
    InputStream is = new URL(url).openStream();
    try {
      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
      String jsonText = readAll(rd);
      JSONObject json = new JSONObject(jsonText);
      return json;
    } finally {
      is.close();
    }
  }
  
  public static void main(String[] args) throws IOException, JSONException {
	
	Map<String,String> quoteshash = null;
    boolean singlequotebool;
	
    // GetList Of Stocks
    List<String> StockList = GetStockListFromDB("NAS");     
    String EscapedStockList = String.join(",", StockList);
    EscapedStockList = URLEncoder.encode(EscapedStockList, "UTF-8");
    System.out.println(EscapedStockList);
    
    String StringURL = "https://query.yahooapis.com/v1/public/yql?q=" +
    		"select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(" + EscapedStockList + 
    		")&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    System.out.println(StringURL);
	// To Test The Query https://developer.yahoo.com/yql/console/?debug=true#h=select+*+from+yahoo.finance.quotes
    //JSONObject json = readJsonFromUrl("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys");
    JSONObject json = readJsonFromUrl(StringURL);

    
    System.out.println(json.toString());

    // Recurse the JSON object to the results JSON object
    JSONObject query = json.getJSONObject("query");
    JSONObject results = query.getJSONObject("results");
    
    // Count Number of keys in results to determine getJSON or JSON Array.
    System.out.print("NumberOfKeys-"+results.length());

	try { 	results.getJSONArray("quote");
    		singlequotebool = false;  }
    catch (Exception e) { singlequotebool = true; }
    			
    // If many quotes returned object is JSON array otherwise object!
    if (singlequotebool==true) {
        JSONObject quote = results.getJSONObject("quote");
        quoteshash = ProcessQuoteData(quote);
        System.out.print("NumberOfHashKeys-"+quoteshash.size());
        InsertStockDetail(quoteshash);
    }
    else{
    	
    	JSONArray quote = results.getJSONArray("quote");
        
	    for (int i = 0, size = quote.length(); i < size; i++)
	    {
	      JSONObject objectInArray = quote.getJSONObject(i);	
	      quoteshash = ProcessQuoteData(objectInArray);
	      InsertStockDetail(quoteshash);
	    }       	
    }
  }  // Sub
  
  public static Map<String,String> ProcessQuoteData(JSONObject json) {
	  
	  HashMap<String, String> out = new HashMap<String,String> ();
	  
      // "...and get thier component and thier value."
      String[] elementNames = JSONObject.getNames(json);
      System.out.printf("%d ELEMENTS IN CURRENT OBJECT:\n", elementNames.length);
      for (String elementName : elementNames)
      {
    	try {  
        String value = json.getString(elementName);
        System.out.printf("name=%s, value=%s\n", elementName, value);
        out.put(elementName,value);
    	}
    	catch (Exception e){
    		// Do Nothing
    	}	
      }
      System.out.print("NumberOfHashKeys-"+out.size());
	  return out;	  
  }
    
  public static void InsertStockDetail (Map<String,String> input) {

		 Connection con = null;  	 
		 
		 String symbol = (String) input.get("symbol");
		 String name = (String) input.get("Name");
		 String bid = (String) input.get("Bid");
		 String ask = (String) input.get("Ask");
		 String YearHigh = (String) input.get("YearHigh");
		 String YearLow = (String) input.get("YearLow");		 
		 String PreviousClose = (String) input.get("PreviousClose");		 
		 String Currency = (String) input.get("Currency");
		 String BookValue = (String) input.get("BookValue");
		 String EarningsShare = (String) input.get("EarningsShare");
		 String PEGRatio = (String) input.get("PEGRatio");
		 String ChangeFromYearLow = (String) input.get("ChangeFromYearLow");
		 String ChangeFromTwoHundreddayMovingAverage = (String) input.get("ChangeFromTwoHundreddayMovingAverage");
		 String YearRange = (String) input.get("YearRange");
		 String ChangeFromFiftydayMovingAverage = (String) input.get("ChangeFromFiftydayMovingAverage");		 
		 String Volume = (String) input.get("Volume");
		 String AverageDailyVolume = (String) input.get("AverageDailyVolume");
		 String ShortRatio = (String) input.get("ShortRatio");
		 String EPSEstimateNextYear = (String) input.get("EPSEstimateNextYear");
		 String EPSEstimateNextQuarter = (String) input.get("EPSEstimateNextQuarter");
		 String PriceEPSEstimateCurrentYear = (String) input.get("EPSEstimateCurrentYear");
		 String DaysRange = (String) input.get("DaysRange");			 
		 String MarketCapitalization = (String) input.get("MarketCapitalization");
		 String EBITDA = (String) input.get("EBITDA");			 
		 String PriceBook = (String) input.get("PriceBook");
		 String PriceSales = (String) input.get("PriceSales");	
		 String LastTradePriceOnly = (String) input.get("LastTradePriceOnly");
		 String Open = (String) input.get("Open");
		 
		 String LastTradeDateStr = (String) input.get("LastTradeDate");			 
		 DateFormat df = new SimpleDateFormat("MM/DD/YYYY");
	     java.util.Date parsed = null;
	     java.sql.Date LastTradeDate = null;
		 if (LastTradeDateStr!=null) {
	     try {
			parsed = df.parse(LastTradeDateStr);
		 } catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		 }
	     LastTradeDate = new java.sql.Date(parsed.getTime());
		 }				 
		 
	    // Write Class Data To The DB
		try {
			con = SqlMySQLConn.getConnection();
			
			WriteStockDetailtoDB(symbol, name, bid, ask, YearHigh, YearLow,
					PreviousClose, Currency, LastTradeDate, BookValue, EarningsShare,
					PEGRatio, ChangeFromYearLow, ChangeFromTwoHundreddayMovingAverage, 
					YearRange, ChangeFromFiftydayMovingAverage, Volume, AverageDailyVolume,
					ShortRatio, EPSEstimateNextYear, EPSEstimateNextQuarter, PriceEPSEstimateCurrentYear,
					DaysRange, MarketCapitalization, EBITDA, PriceBook, PriceSales,
					LastTradePriceOnly, Open, con);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			SqlMySQLConn.close(con);
		}    	  
  }
  
  public static void WriteStockDetailtoDB(String StockId, String StockName, 
		  String StockBid, String StockAsk, String YearHigh, String YearLow,
		  String PreviousClose, String Currency, Date LastTradeDate,
		  String BookValue, String EarningsShare, String PEGRatio, 
		  String ChangeFromYearLow, String ChangeFromTwoHundreddayMovingAverage, 
		  String YearRange, String ChangeFromFiftydayMovingAverage, String Volume, String AverageDailyVolume,
		  String ShortRatio, String EPSEstimateNextYear, String EPSEstimateNextQuarter, String PriceEPSEstimateCurrentYear,
		  String DaysRange, String MarketCapitalization, String EBITDA, String PriceBook, String PriceSales,
		  String LastTradePriceOnly, String Open	  
		  ,Connection wrtCon)
  {
	  
      String InsrtSql = "INSERT INTO hokus.stock_detail " +
              " ( stock_id, stock_name, stock_bid, stock_ask, YearHigh, " +
    		  " YearLow, PreviousClose, Currency, LastTradeDate, BookValue, EarningsShare, "  +
			  "	PEGRatio, ChangeFromYearLow, ChangeFromTwoHundreddayMovingAverage,  " +
			  "	YearRange, ChangeFromFiftydayMovingAverage, Volume, AverageDailyVolume, " +
			  " ShortRatio, EPSEstimateNextYear, EPSEstimateNextQuarter, PriceEPSEstimateCurrentYear, " +
			  "	DaysRange, MarketCapitalization, EBITDA, PriceBook, PriceSales, " +
			  "	LastTradePriceOnly, Open  ) " +
              " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
      java.sql.PreparedStatement pstmt;
      
      System.out.println(InsrtSql);
	  
      try
      {  
          pstmt = wrtCon.prepareStatement(InsrtSql);
          wrtCon.setAutoCommit(true);    
    	  pstmt.setString (1, StockId); 
    	  pstmt.setString (2, StockName); 
    	  pstmt.setString (3, StockBid); 
    	  pstmt.setString (4, StockAsk);   
    	  pstmt.setString (5, YearHigh); 
    	  pstmt.setString (6, YearLow); 
    	  pstmt.setString (7, PreviousClose); 
    	  pstmt.setString (8, Currency); 
    	  pstmt.setDate (9, LastTradeDate); 
    	  pstmt.setString (10, BookValue); 
    	  pstmt.setString (11, EarningsShare); 
    	  pstmt.setString (12, PEGRatio); 
    	  pstmt.setString (13, ChangeFromYearLow); 
    	  pstmt.setString (14, ChangeFromTwoHundreddayMovingAverage); 
    	  pstmt.setString (15, YearRange); 
    	  pstmt.setString (16, ChangeFromFiftydayMovingAverage); 
    	  pstmt.setString (17, Volume); 
    	  pstmt.setString (18, AverageDailyVolume);    	  
    	  pstmt.setString (19, ShortRatio); 
    	  pstmt.setString (20, EPSEstimateNextYear); 
    	  pstmt.setString (21, EPSEstimateNextQuarter); 
    	  pstmt.setString (22, PriceEPSEstimateCurrentYear); 
    	  pstmt.setString (23, DaysRange); 
    	  pstmt.setString (24, MarketCapitalization); 
    	  pstmt.setString (25, EBITDA); 
    	  pstmt.setString (26, PriceBook); 
    	  pstmt.setString (27, PriceSales); 
    	  pstmt.setString (28, LastTradePriceOnly); 
    	  pstmt.setString (29, Open); 
    	  
           pstmt.addBatch();
           pstmt.executeBatch();
           System.out.println ("Committed.");
      }
      catch(Exception sqle)
      {
              System.out.println ("Exception in writing to the database "+ sqle.getMessage());
      }
  }
  
  public static List<String> GetStockListFromDB(String Exchange) {
	
	  List<String> stocks = new ArrayList<String>();
	  Connection con;
	  // Get Stocks Which do not have a Entry on rundate.
	  // Rundates need to tie in with market close times by Exc.
	  String query = "SELECT stock_id "
              + "FROM hokus.stock s " +
			    " WHERE NOT EXISTS (   " +
                "			SELECT 1 FROM hokus.stock_detail sd " +
			    "			WHERE sd.stock_id = s.stock_id " +
                " 			AND DATE(sd.stock_date) = DATE(sysdate()) )";
	  System.out.print(query);
	  
		try {
			con = SqlMySQLConn.getConnection();
			Statement stmt = con.createStatement();			
			ResultSet rs = stmt.executeQuery(query);
		    while (rs.next()) {
		    	  stocks.add("'"+rs.getString(1)+"'");

		    }			
		    con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	return stocks;
  }
  
  
} // class

