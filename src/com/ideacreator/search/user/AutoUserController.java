package com.ideacreator.search.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.ideacreator.user.UserDAO;

public class AutoUserController extends HttpServlet {
	
	private JsonArray userDetails=null;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserDAO userdo= new UserDAO();
		userDetails= userdo.getUsersArray();
		
		PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        
        JsonArray arrayObj=new JsonArray();
        
        String query = request.getParameter("term");
        System.out.println(query);
        query = query.toLowerCase();
        Iterator<JsonElement> it = userDetails.iterator();
        
        while(it.hasNext()){
        	JsonElement temp=it.next();
        	JsonObject obj=new JsonObject();
        	String userName=((JsonObject)temp).get("userName").getAsString().toLowerCase();
        	if(userName.contains(query)){
        		arrayObj.add(((JsonObject)temp).get("userName"));
        	}
        }
        
        out.println(arrayObj.toString());
        out.close();
	}

}
