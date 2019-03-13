/*
 * 
 * Name: Mariel Martinez (marmarie)
 * Assignment: A2_marmarie (Assignment 2)
 * Program: Computer Programmer
 * Course: PROG 32758
 * Instructor: Wendi Jollymore
 * Date Created: 24-Sep-2018
 * Date Modified: 13-Oct-2018
 * File: OrderCustomTree.java
 * 
 * Description:
 *      This servlet will process an order for a cat tree,
 *      and output the order information (e.g. type of fabric,
 *      options selected, bill total). If the inputs are valid,
 *      it will forward to showInvoice.jsp. Otherwise, it will
 *      throw a ServletException
 *
 */
package ca.sheridancollege.marmarie.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ca.sheridancollege.java3.a1.Customer;
import ca.sheridancollege.java3.a1.Fabric;
import ca.sheridancollege.java3.a1.Options;
import ca.sheridancollege.java3.a1.CustomOrder;
import javax.servlet.http.HttpSession;

public class OrderCustomTree extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * 
     * Will output Custom order details if data retrieved from form is valid,
     *  otherwise will output errors to user.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String errors = ""; // Stores any error messages that occur
        HttpSession session = request.getSession(); // Stores form variables

        // Retrieve customer ID and ensure it is not empty
        String txtCustId = request.getParameter("custId");
        session.setAttribute("id", txtCustId); // store id in session
        int custId = -1;
        if (!txtCustId.trim().isEmpty()) {
            // Ref: https://bit.ly/2NQ48zw
            if (txtCustId.matches("\\d+")) {
                custId = Integer.parseInt(txtCustId);
            } else {
                errors += "Customer ID must contain only digits.<br>";
            }
        } else {
            errors += "Customer ID is a mantatory field.<br>";
        }
        
        // Retrieve email and ensure it is not empty
        String email = request.getParameter("custEmail");
        session.setAttribute("email", email); // store email in session
        if (email.trim().isEmpty()) {
            errors += "Email is a mantatory field.<br>";
        }
        
        // Create Customer object if no errors
        Customer customer = null;
        if (errors.trim().isEmpty()) {
            try {
                // Customer Object
                customer = new Customer(custId, email);
            } catch (IllegalArgumentException e) {
                errors += e.getMessage() + "<br>";
            }
        }

        // Retrieve Fabric
        String txtFabric = request.getParameter("lstFabric");
        Fabric fabric = null;
        if (txtFabric != null && !txtFabric.trim().isEmpty()) {
            try {
                fabric = Fabric.valueOf(txtFabric);
            } catch (IllegalArgumentException | NullPointerException e) {
                errors += e.getMessage() + "<br>";
            }
            session.setAttribute("selFabric", fabric); // Fabric obj in session
        } else {
            session.removeAttribute("selFabric"); // fabric selection is empty
            errors += "You must choose a fabric.<br>";
        }

        // Retrieve levels
        String txtLevel = request.getParameter("optLevels");
        int levels = 0;
        if (txtLevel != null) {
            levels = Integer.parseInt(txtLevel);
            session.setAttribute("selLevels", levels);
        } else {
            session.removeAttribute("selLevels"); // level selection is empty
            errors += "Number of levels is mandatory.<br>";
        }

        // Retrieve Options if any were selected
        String[] txtOptions = request.getParameterValues("chkExtras[]");
        Options[] options = null;
        if (txtOptions != null) {
            options = new Options[txtOptions.length];
            for (int i = 0; i < options.length; i++) {
                try {
                    options[i] = Options.valueOf(txtOptions[i]);
                } catch (IllegalArgumentException | NullPointerException e) {
                    errors += e.getMessage() + "<br>";
                }
            }
            session.setAttribute("selOptions", options); // options in session
        } else {
            session.removeAttribute("selOptions"); // options selects are empty
        }

        // Throw errors with form input
        if (!errors.trim().isEmpty()) {
            throw new ServletException(errors);
        }
        
        // Create CustomOrder object if no errors
        CustomOrder order = null;
        if (errors.trim().isEmpty()) {
            try {
                // Call appropriate constructor
                if (options == null) {
                    order = new CustomOrder(1, customer, levels, fabric);
                } else {
                    order = new CustomOrder(1, customer, fabric, levels,
                        options);
                }
            } catch (IllegalArgumentException e) {
                throw new ServletException(e.getMessage());
            }
        }

        // Destroy session if no errors were thrown up to this point
        // Ensures that form will be empty for new invoices
        session.removeAttribute("id");
        session.removeAttribute("email");
        session.removeAttribute("selFabric");
        session.removeAttribute("selLevels");
        session.removeAttribute("selOptions");
        session.invalidate();
        session = null;
        
        // Add order to request scope and forward to showInvoice.jsp
        request.setAttribute("order", order);
        request.getRequestDispatcher("showInvoice.jsp")
                .forward(request, response);
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, 
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, 
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
