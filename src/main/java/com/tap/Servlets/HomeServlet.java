package com.tap.Servlets;

import java.io.IOException;
import java.util.List;

import com.tap.dapimplementation.ResturantDaoImpl;
import com.tap.model.Resturant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/home")
public class HomeServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	System.out.println("HomeServlet: Received GET request at /home");
	ResturantDaoImpl resturantDao = new ResturantDaoImpl();
	List<Resturant> allResturants = resturantDao.getallResturant();
	
	int count = (allResturants != null) ? allResturants.size() : 0;
	System.out.println("HomeServlet: Setting 'resturants' attribute with " + count + " items");
	req.setAttribute("resturants", allResturants);
	
	System.out.println("HomeServlet: Forwarding to home.jsp");
	RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
	rd.forward(req, resp);
  }
}


	
