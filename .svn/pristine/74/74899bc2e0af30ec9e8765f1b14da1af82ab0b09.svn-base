<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/협력업체위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00312P_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 서버 사진 조회                                                                                                                                               
■ 작성일자     : 2015-02-09                                                                                                                                                                            
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     : 2015-02-09                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ page language="java" import="java.util.*,java.io.*" %>
<%@ page language="java" import="java.util.*,java.net.*" %>
<%@ page language="java" import="javax.imageio.ImageIO" %>
<%@ page language="java" import="java.awt.Image" %>
<%@ page language="java" import="javax.swing.ImageIcon" %>
<%@ page language="java" import="java.awt.Graphics2D" %>
<%@ page language="java" import="java.awt.image.BufferedImage" %>
<%@ include file = "../../sc/main/common.jsp" %>       

<%
	ByteArrayOutputStream baos = null;
	FileInputStream fis = null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		// 데이터셋 생성
		DataSet ds_cond        = in_dl.get("ds_cond");
        DataSet ds_imgeSvrList = in_dl.get("ds_imgeSvrList");
        ds_imgeSvrList.clearData();

        // 디렉토리 패스
        String REG_DD   = ds_cond.getString(0, "REG_DD");
        String BASE_DIR = "C:\\HWFS_DEV\\workspace\\hwfs\\WebContent\\upload\\fs\\fsc\\photo\\" + REG_DD;

        BufferedReader br = null;
   
        int maxDim = 70;
        int bytesRead = 0;
        byte[] buff = new byte[1024];
        
		File file = new File(BASE_DIR + "\\");
		
		BufferedInputStream bis = null;
		BufferedImage bi = null;
		BufferedImage bufferIm = null;
		Image inImage = null;
		Image temp = null;
		Graphics2D g2 = null;

		File[] listFiles = file.listFiles();
		if (listFiles == null) {
			String strMsg = "등록된 이미지가 존재하지 않습니다. \n";
			this.setResultMessage(-1, strMsg ,out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		
		for (int i=0; i<listFiles.length; i++) {
			
			bis = new BufferedInputStream(new FileInputStream(listFiles[i]));
			bi = ImageIO.read(bis);
			inImage = new ImageIcon(listFiles[i].getCanonicalPath()).getImage();
			
			// 비율 조정
			double scale = (double)maxDim / (double)inImage.getHeight(null);
			if (inImage.getWidth(null) > inImage.getHeight(null)) {
				scale = (double)maxDim / (double)inImage.getWidth(null);
			}

			int width = (int)(scale * inImage.getWidth(null));
			int height = (int)(scale * inImage.getHeight(null));

			bufferIm = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			temp = bi.getScaledInstance(width, height, Image.SCALE_AREA_AVERAGING);
			g2 = bufferIm.createGraphics();
			g2.drawImage(temp, 0, 0, width, height, null);

			baos = new ByteArrayOutputStream();
			ImageIO.write(bufferIm, "jpg", baos);
			
			System.out.println("length : " + baos.toByteArray().length);
			
/* 			fis = new FileInputStream(new File(bufferIm));
			while((bytesRead = fis.read(buff)) > 0) {
				baos.write(buff, 0, bytesRead);
			}
			
			baos.flush();
 */			
			int nRow = ds_imgeSvrList.newRow();
	        ds_imgeSvrList.set(nRow, "CHK",               "0");	
	        ds_imgeSvrList.set(nRow, "SRLNUM",            "");	
	        ds_imgeSvrList.set(nRow, "TABLE_TYPE",        "");	
	        ds_imgeSvrList.set(nRow, "FORM_CD",           "");
	        ds_imgeSvrList.set(nRow, "CUSTCD",            "");
	        ds_imgeSvrList.set(nRow, "CHK_DD",            "");
	        ds_imgeSvrList.set(nRow, "CLASS_CD",          "");
	        ds_imgeSvrList.set(nRow, "ORGNL_IMGE",        listFiles[i].getName());
	        ds_imgeSvrList.set(nRow, "SVR_IMGE",          listFiles[i].getName());
	        ds_imgeSvrList.set(nRow, "FILE_SIZE",         listFiles[i].length());
	        ds_imgeSvrList.set(nRow, "IMPROV_ORGNL_IMGE", "");
	        ds_imgeSvrList.set(nRow, "IMPROV_SVR_IMGE",   "");
	        ds_imgeSvrList.set(nRow, "IMPROV_FILE_SIZE",  "");
	        ds_imgeSvrList.set(nRow, "CUSER",             "");
	        ds_imgeSvrList.set(nRow, "CDATE",             "");
	        ds_imgeSvrList.set(nRow, "UUSER",             "");
	        ds_imgeSvrList.set(nRow, "UDATE",             "");
	        ds_imgeSvrList.set(nRow, "PRE_VIEW",          baos.toByteArray());
	        ds_imgeSvrList.set(nRow, "FILE_PATH",         "");
	        ds_imgeSvrList.set(nRow, "IMPROV_PRE_VIEW",   "");
	        ds_imgeSvrList.set(nRow, "IMPROV_FILE_PATH",  "");
	        ds_imgeSvrList.set(nRow, "IMPROV_YN",         "");
	        ds_imgeSvrList.set(nRow, "SUB_COMP_NM",       "");
		}
		
		//fis.close();
		baos.close();
        
		/**종료**/
		out_dl.add(ds_imgeSvrList);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);                                                                                                                                                    
	}                                                                                                                                                                                                     
	finally                                                                                                                                                                                               
	{
		//try {fis.close();} catch(IOException e) {e.printStackTrace();}
		try {baos.close();} catch(IOException e) {e.printStackTrace();}
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}                                                                                                                                                                                                     
                                                                                                                                                                                                        
	proc_output(response, out, out_vl, out_dl);                                                                                                                                                              
                                                                                                                                                                                                        
%>