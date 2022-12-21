package com.hwfs.batch.fm.fms.dao;

import hone.core.util.record.RecordMetadata;
import hone.core.util.record.RecordSet;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.fm.fms.dao.CustSysInterfaceSISMssqlDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.cmn.util.FtpUtil;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsCustSysInterfaceSISDAO.java
 * @Description FmsCustSysInterfaceSISDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.07.06.   kihoon        쓰레기생성
 * </pre>
 * @author kihoon
 * @since 2020. 07. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsCustSysInterfaceSISDAO")
public class FmsCustSysInterfaceSISDAO extends DefaultBatchDAO {

    /**
     * 
     * @param parameter
     * @return
     * @throws Exception
     */
	
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;
	

	/** CustSysInterfaceSISMssqlDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceSISMssqlDAO")
	private CustSysInterfaceSISMssqlDAO custSysInterfaceSISMssqlDAO;
	
	@Resource(name ="transactionManagerSIS")
	private PlatformTransactionManager txManger;
	
    /** LogService */
	private final static Logger logger = LoggerFactory.getLogger(FmsCustSysInterfaceSISDAO.class);
	
	public String batchJobItem(Map<String, Object> mapParam) throws Exception {
		
		String strSource = "";
		String ftpResult = "";
		RecordSet rs;
		
		try {
			 
			rs = super.queryForRecordSet("fm.fms.custSysInterfaceSISDAO.selectItemBatch", mapParam);
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder =factory.newDocumentBuilder();
			Document doc = builder.newDocument();
			
			Element items = doc.createElement("items");
			doc.appendChild(items);
			      
			RecordMetadata rsmd = rs.getMetadata();
			int colCount        = rs.getColumnCount();
			int rowCount		= rs.getRowCount();
			
			logger.debug("###### MAKE XML DOCUMENT ######");
			
			for ( int z=0; z<rowCount; z++ ) {
			      Element item = doc.createElement("item");
			      items.appendChild(item);

			      for (int i=0; i<colCount; i++) {
			         String columnName = rsmd.getKey(i);
			         String value      = rs.get(z).getString(columnName);
			         
			         //System.out.println(columnName+"="+value);
						
			         Element node      = doc.createElement(columnName);
			         node.appendChild(doc.createTextNode(value == null ? "" : value.toString()));
			         item.appendChild(node);
			      }
			 }
		
			strSource = getDocumentAsXml(doc);
			ftpResult = sendFile(strSource);
			
			logger.debug("###### COMPLETED ######");
		
		} catch ( Exception e) {
			
			throw e;
		}
    	
		return ftpResult;
    }
	
	public Integer batchJobSubinv(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs;
		Integer procCnt = 0;
		
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
				
		try {
			rs = super.queryForRecordSet("fm.fms.custSysInterfaceSISDAO.selectSubinvBatch", mapParam);
			
			for ( int i=0; i<rs.getRowCount(); i++ ) {
				Map<String, Object> rowData = rs.get(i);
				procCnt += custSysInterfaceSISMssqlDAO.updateSubinvInfo(rowData);
			}
			txManger.commit(txStatus);
		} catch ( Exception e) {
			txManger.rollback(txStatus);
			throw e;
		}
    	
		return procCnt;
    }

	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
	
	RecordSet rs;
	Integer procCnt = 0;
	
	TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
			
	try {
		rs = super.queryForRecordSet("fm.fms.custSysInterfaceSISDAO.selectSuspenseBatch", mapParam);
		
		for ( int i=0; i<rs.getRowCount(); i++ ) {
			Map<String, Object> rowData = rs.get(i);
			procCnt += custSysInterfaceSISMssqlDAO.updateSuspenseInfo(rowData);
		}
		txManger.commit(txStatus);
	} catch ( Exception e) {
		txManger.rollback(txStatus);
		throw e;
	}
	
	return procCnt;
}
	
	private String getDocumentAsXml(Document doc) throws TransformerConfigurationException, TransformerException {
		
			logger.debug("###### MAKE XML FILE ######");
		
		    DOMSource domSource = new DOMSource(doc);
		    TransformerFactory tf = TransformerFactory.newInstance();
		    Transformer transformer = tf.newTransformer();
		    transformer.setOutputProperty(OutputKeys.METHOD, "XML");
		    transformer.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
		    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		    java.io.StringWriter sw = new java.io.StringWriter();
		    //StreamResult sr = new StreamResult(sw);
		    //transformer.transform(domSource, sr);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd_HHmmss");
			String fileName = formatter.format(new java.util.Date());
			
			String mode = propertiesService.getString("run.mode");
			String sourceFile = "";
			
			if ( "localhost".equals(mode) ) {
				sourceFile = "C:\\HWFS_DEV\\workspace\\"+fileName+".xml";
				
			} else {
				sourceFile = propertiesService.getString("global.filerepository.path") 
							+ propertiesService.getString("cmn.file.path") + "/sis/" + fileName+".xml";
			}
		    StreamResult sr = new StreamResult(new File(sourceFile));
		    
		    transformer.transform(domSource, sr);
		    //return sw.toString();
		    return sourceFile;
	}
	
	private String sendFile(String sourceFile) throws Exception {
		
		logger.debug("###### TRANSFER XML FILE ######");
		/*
		logger.debug("hostName:"+propertiesService.getString("sis.ftp.host"));
		logger.debug("port:"+propertiesService.getString("sis.ftp.port"));
		logger.debug("userName:"+propertiesService.getString("sis.ftp.userName"));
		logger.debug("userPwd:"+propertiesService.getString("sis.ftp.userPwd"));
		*/
		
		int putCnt = -1;
		FTPClient client = null;
		String toFile = "";
		
		try {
			
			client = FtpUtil.connnect(
						propertiesService.getString("sis.ftp.host")
						, propertiesService.getInt("sis.ftp.port")
						, propertiesService.getString("sis.ftp.userName")
						, propertiesService.getString("sis.ftp.userPwd")
						, "euc-kr");
			logger.debug("FTP Login...");
			client.enterLocalPassiveMode();
			//client.enterLocalActiveMode();
			logger.debug("FTP Set PassiveMode...");
			
			List<String> putList = new ArrayList<String>();
						 putList.add(sourceFile);
			
						 
			for (int i=0; i<putList.size(); i++) {
				String fromFile = putList.get(i);
				File file = new File(fromFile);
				if ( !file.exists() ) continue;
				
				if ( "server".equals(propertiesService.getString("run.mode")) ) {
					toFile = file.getName();
				} else {
					toFile = "[TEST]" + file.getName();
				}
				if ( FtpUtil.put(client, fromFile, toFile) ) {
					putCnt = i;				
				}
			}
			logger.debug("FTP File Transfer...");
			
			FtpUtil.logout(client);
			logger.debug("FTP Logout...");
			
		} catch ( Exception e ) {
			logger.debug("###### TRANSFER XML FILE ERROR ######");
			logger.debug(e.getMessage().toString());
			putCnt = -1;
		}
		
		return toFile;
	}
}
