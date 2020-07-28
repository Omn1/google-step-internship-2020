package com.google.sps.servlets;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@WebServlet("/blobstore-upload-url")
public class BlobstoreUploadUrlServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    String forward = request.getParameter("forward");

    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    String uploadUrl = blobstoreService.createUploadUrl(forward);

    response.setContentType("text/html");
    response.getWriter().println(uploadUrl);
  }
}
