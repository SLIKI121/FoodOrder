package com.tap.Servlets;

import java.io.IOException;
import java.util.List;

import com.tap.dapimplementation.MenuDaoImpl;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Menu")
public class MenuServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		System.out.println("Menu servlet called");

		MenuDaoImpl MenuDao = new MenuDaoImpl();

		List<Menu> allMenuList = MenuDao.getMenuByRestaurant(restaurantId);

		req.setAttribute("allmenuList", allMenuList);

		RequestDispatcher rd = req.getRequestDispatcher("Menu.jsp");
		rd.forward(req, resp);
	}
}
