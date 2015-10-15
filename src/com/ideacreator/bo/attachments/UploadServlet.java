package com.ideacreator.bo.attachments;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.ideacreator.user.UserInfo;

public class UploadServlet extends HttpServlet {

	private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 50 * 1000000000;
	private int maxMemSize = 4 * 1000000000;
	private File file;

	public void init() {
		// Get the file location where it would be stored.
		filePath = getServletContext().getInitParameter("file-upload");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {
		// Check that we have a file upload request
		isMultipart = ServletFileUpload.isMultipartContent(request);
		response.setContentType("text/html");
		final java.io.PrintWriter out = response.getWriter();
		if (!isMultipart) {
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet upload</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<p>No file uploaded</p>");
			out.println("</body>");
			out.println("</html>");
			return;
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(maxMemSize);
		// Location to save data that is larger than maxMemSize.
		factory.setRepository(new File("c:\\Temp"));

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum file size to be uploaded.
		upload.setSizeMax(maxFileSize);
		upload.setProgressListener(new ProgressListener() {
			private long megaBytes = -1;

			@Override
			public void update(long pBytesRead, long pContentLength, int pItems) {
				// TODO Auto-generated method stub
				long mBytes = pBytesRead / 1000000;
				if (megaBytes == mBytes) {
					return;
				}
				megaBytes = mBytes;
				System.out.println("We are currently reading item " + pItems);
				System.out.print("We are currently reading item " + pItems);
				if (pContentLength == -1) {
					System.out.println("So far, " + pBytesRead + " bytes have been read.");
					System.out.println("So far, " + pBytesRead + " bytes have been read.");
				} else {

					System.out.println("So far, " + pBytesRead + " of " + pContentLength + " bytes have been read.");
					System.out.println("So far, " + pBytesRead + " of " + pContentLength + " bytes have been read.");
				}
			}
		});
		try {
			// Parse the request to get file items.
			List fileItems = upload.parseRequest(request);
			HttpSession session= request.getSession();
			UserInfo user = (UserInfo)session.getAttribute("loggedInUser");
			List<String> fileNames = new ArrayList<String>();
			// Process the uploaded file items
			Iterator i = fileItems.iterator();

			/*
			 * out.println("<html>"); out.println("<head>"); out.println(
			 * "<title>Servlet upload</title>"); out.println("</head>");
			 * out.println("<body>");
			 */
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				if (!fi.isFormField()) {
					// Get the uploaded file parameters
					String fieldName = fi.getFieldName();
					String fileName = fi.getName();
					String contentType = fi.getContentType();
					boolean isInMemory = fi.isInMemory();
					long sizeInBytes = fi.getSize();
					// Write the file
					if (fileName.lastIndexOf("\\") >= 0) {
						fileNames.add(user.getUserId()+fileName.substring(fileName.lastIndexOf("\\")));
						file = new File(filePath + user.getUserId()+fileName.substring(fileName.lastIndexOf("\\")));
					} else {
						fileNames.add(user.getUserId()+fileName.substring(fileName.lastIndexOf("\\")+1));
						System.out.println(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
						file = new File(filePath + user.getUserId()+fileName.substring(fileName.lastIndexOf("\\") + 1));
					}
					fi.write(file);
					String displayFileName =fileName.substring(0,fileName.lastIndexOf("."));
					displayFileName=displayFileName.length()>25?displayFileName.substring(0, 25).concat("..."):displayFileName;
					System.out.println("File Name"+fileName);
					String tempFileExt= fileName.substring(fileName.lastIndexOf("."));
					out.println("<div class=\"attachment\" title=\"Click to Download the Attachment!\">"
							+ "<p>"+displayFileName+tempFileExt+"</p>" + "<div class=\"overlay\">"
							+ "<a href=\"DownloadAttachment?fileName="+fileName+"\" style\"text-decoration: none;color:back;\""
							+ "<button class=\".btn glyphicon glyphicon-download-alt\" title=\"Preview/Delete Attachment\" style=\"margin-left:20px; margin-top:20px\"></button></a>" 
							+ "<button class=\".btn glyphicon glyphicon-trash\" style=\"margin-left:20px; margin-top:20px\" title=\"Delete Attachment\"></button>"
							+ "</div>" + "</div>");
				}
			}
			
			session.setAttribute("attachments", fileNames);
			/*
			 * out.println("</body>"); out.println("</html>");
			 */
		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {

		throw new ServletException("GET method used with " + getClass().getName() + ": POST method required.");
	}
}