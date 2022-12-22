package com.hwfs.sc.cmn.sap.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.Consts;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.sc.cmn.sap.EAIList;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.EAITable;
import com.hwfs.sc.cmn.sap.dao.EAIListDAO;
import com.hwfs.sc.cmn.sap.dao.EAILogDAO;
import com.hwfs.sc.cmn.sap.dao.EAITableDAO;

/**
 * EAI를 호출하여 그 결과를 수신한다.
 *
 * @ClassName EAIService.java
 * @Description EAIService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 9.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 9.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("EAIService")
public class EAIServiceImpl extends DefaultServiceImpl implements EAIService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "EAILogDAO")
	EAILogDAO dao;

	@Resource(name = "EAITableDAO")
	EAITableDAO tableDao;

	@Resource(name = "EAIListDAO")
	EAIListDAO listDao;

	/**
	 * EAI를 직접 호출하여 그 결과를 수신한다.(단건자료)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	public EAIResponse call(EAIRequest eaiRequest) throws Exception {
		String interfaceId = eaiRequest.getInterfaceId();
		JSONObject parameter = eaiRequest.getJSONObject(super.propertiesService
				.getString("eai.system.code"));

		String logRefKey = UUIdGenUtil.getUUID();
		
		try {
			logWriteNewTx(logRefKey, interfaceId, "Request", parameter, "N");
		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Request Exception", e, "Y");
			logger.error(e.getMessage());
		}

		EAIResponse res = new EAIResponse(this.call(interfaceId, parameter));

		try {
			if (res.getErrorCode() == -999) {
				logWriteNewTx(logRefKey, interfaceId, "Error", res.getErrorMsg(), "Y");
			}
			else {
				logWriteNewTx(logRefKey, interfaceId, "Response", res.getJSONObject(), "N");
			}
		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Response Exception", e, "Y");
			logger.error(e.getMessage());
		}

		return res;
	}

	/**
	 * EAI를 직접 호출하여 그 결과를 수신한다.(다건자료)
	 *
	 * @param eaiRequests
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.service.EAIService#call(java.util.List)
	 */
	public EAIResponse call(List<EAIRequest> eaiRequests) throws Exception {
		String interfaceId = "";
		JSONObject parameter = new JSONObject();
		JSONArray itemList = new JSONArray();

		for (int i = 0; i < eaiRequests.size(); i++) {
			interfaceId = eaiRequests.get(i).getInterfaceId();
			itemList.put(
					i,
					eaiRequests
							.get(i)
							.getJSONObject(
									super.propertiesService
											.getString("eai.system.code"))
							.getJSONObject("ITEM01"));
		}

		parameter.put("ITEM01", itemList);

		String logRefKey = UUIdGenUtil.getUUID();

		try {
			logWriteNewTx(logRefKey, interfaceId, "Request", parameter, "N");
		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Exception", e, "Y");
			logger.error(e.getMessage());
		}

		EAIResponse res = new EAIResponse(this.call(interfaceId, parameter));

		try {
			if (res.getErrorCode() == -999) {
				logWriteNewTx(logRefKey, interfaceId, "Error", res.getErrorMsg(), "Y");
			}
			else {
				logWriteNewTx(logRefKey, interfaceId, "Response", res.getJSONObject(), "N");
			}
		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Exception", e, "Y");
			logger.error(e.getMessage());
		}

		return res;
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.(단건)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param eaiTable
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.service.EAIService#call(com.hwfs.sc.cmn.sap.EAITable)
	 */
	@SuppressWarnings("unchecked")
	public EAIResponse call(EAITable eaiTable) throws Exception {
		String interfaceId = eaiTable.getInterfaceId();
		int procCnt = 0;
		StringBuffer message = new StringBuffer();
		boolean isSuccess = false;
		int errorCode = 0;
		String errorMessage = "";
		String logRefKey = UUIdGenUtil.getUUID();

		message.append("{\"message\":{\"RESULT\":[");

		try {
			Map<String, Object> singleData = (Map<String, Object>) eaiTable
					.getData();

			logWriteNewTx(logRefKey, interfaceId, "Request", singleData, "N");

			if (!"".equals(eaiTable.getDeleteQueryId())) {
				int delCnt = tableDao.insert(eaiTable.getDeleteQueryId(),
						singleData);
				message.append("\"PROC_DELETE\":\"OK\",\"PROC_DELETE_COUNT\":");
				message.append(delCnt);
			}

			procCnt = tableDao.insert(eaiTable.getQueryId(), singleData);

			isSuccess = true;
			message.append("\"PROC_INSERT\":\"OK\", \"PROC_INSERT_COUNT\":");
			message.append(procCnt);
			message.append("}]}}");

		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Exception", e, "Y");
			logger.error(e.getMessage());
			isSuccess = false;
			errorCode = -999;
			errorMessage = e.getMessage();
			message.append("\"exception\":\"");
			message.append(e.getMessage());
			message.append("\"}]}}");
		}

		EAIResponse res = new EAIResponse(message);
		res.isSuccess(isSuccess);
		res.setErrorCode(errorCode);
		res.setErrorMsg(errorMessage);

		return res;
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.(다건)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param eaiList
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.service.EAIService#call(com.hwfs.sc.cmn.sap.EAIList)
	 */
	public EAIResponse call(EAIList eaiList) throws Exception {
		String interfaceId = eaiList.getInterfaceId();
		int procCnt = 0;
		StringBuffer message = new StringBuffer();
		boolean isSuccess = false;
		int errorCode = 0;
		String errorMessage = "";
		String logRefKey = UUIdGenUtil.getUUID();

		message.append("{\"message\":{\"RESULT\":[{");

		try {
			List<?> listData = eaiList.getDataList();
			logWriteNewTx(logRefKey, interfaceId, "Request", listData, "N");

			if (!"".equals(eaiList.getDeleteQueryId())) {
				int delCnt = listDao.insert(eaiList.getDeleteQueryId(),
						listData);
				message.append("\"PROC_DELETE\":\"OK\",\"PROC_DELETE_COUNT\":");
				message.append(delCnt);
			}

			procCnt = listDao.insert(eaiList.getQueryId(), listData);

			isSuccess = true;
			message.append("\"PROC_INSERT\":\"OK\", \"PROC_INSERT_COUNT\":"
					+ procCnt + "}]}}");
		} catch (Exception e) {
			logWriteNewTx(logRefKey, interfaceId, "Exception", e, "Y");
			logger.error(e.getMessage());
			isSuccess = false;
			errorCode = -999;
			errorMessage = e.getMessage();
			message.append("\"exception\":\"" + e.getMessage() + "\"}]}}");
		}

		EAIResponse res = new EAIResponse(message);
		res.isSuccess(isSuccess);
		res.setErrorCode(errorCode);
		res.setErrorMsg(errorMessage);
		return res;
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.(다건-마스터/디테일 구조)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param listMap
	 * @return
	 * @throws Exception
	 */
	public EAIResponse call(EAIListMap listMap) throws Exception {
		Map<String, EAIList> datas = listMap.getDataListMap();
		List<String> keys = listMap.getDataKeyList();
		StringBuffer message = new StringBuffer();
		boolean isSuccess = false;
		int errorCode = 0;
		String errorMessage = "";

		message.append("{\"message\":{\"RESULT\":[{");

		try {
			for (int i = 0; i < keys.size(); i++) {

				EAIResponse procRes = call(datas.get(keys.get(i)));

				if (procRes.isSuccess()) {
					isSuccess = true;
					errorCode = 0;
					errorMessage = "";
					message.append((i == 0 ? "" : ",") + "\"KEY_" + keys.get(i)
							+ "\":\"OK\"");
				} else {
					isSuccess = false;
					errorCode = -1;
					errorMessage = "KEY : " + keys.get(i)
							+ "을(를) 처리하는데 오류가 발생하였습니다.";
					message.append((i == 0 ? "" : ",") + "\"KEY_" + keys.get(i)
							+ "\":\"FAIL\"");
					break;
				}
			}

			message.append("}]}}");
		} catch (Exception e) {
			isSuccess = false;
			errorCode = -999;
			errorMessage = e.getMessage();
			message.delete(0, message.length());
			message.append("{\"message\":{\"RESULT\":[{");
			message.append("\"exception\":\"" + e.getMessage() + "\"}]}}");
		}

		EAIResponse res = new EAIResponse(message);
		res.isSuccess(isSuccess);
		res.setErrorCode(errorCode);
		res.setErrorMsg(errorMessage);
		return res;
	}

	/**
	 * EAI를 호출하여 그 결과를 수신한다.(단건)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	public EAIResponse callNewTx(EAIRequest eaiRequest) throws Exception {
		return call(eaiRequest);
	}

	/**
	 * EAI를 호출하여 그 결과를 수신한다.(다건)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	public EAIResponse callNewTx(List<EAIRequest> eaiRequests) throws Exception {
		return call(eaiRequests);
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param eaiTable
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.service.EAIService#call(com.hwfs.sc.cmn.sap.EAITable)
	 */
	public EAIResponse callNewTx(EAITable eaiTable) throws Exception {
		return call(eaiTable);
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.(다건)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param eaiList
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.service.EAIService#call(com.hwfs.sc.cmn.sap.EAIList)
	 */
	public EAIResponse callNewTx(EAIList eaiList) throws Exception {
		return call(eaiList);
	}

	/**
	 * EAI와 통신하는 Table에 자료를 생성한다.(다건-마스터/디테일 구조)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param listMap
	 * @return
	 * @throws Exception
	 */
	public EAIResponse callNewTx(EAIListMap listMap) throws Exception {
		return call(listMap);
	}

	/**
	 * EAI Service를 JSON형태의 실시간으로 호출한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param interfaceId
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	private StringBuffer call(String interfaceId, JSONObject parameter)
			throws Exception {
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String endPointUrl = "";
		
		if ("NONE".equals(super.propertiesService.getString("eai.mode"))) {
			endPointUrl = super.propertiesService.getString("eai.url") + interfaceId;
		}
		else {
			endPointUrl = super.propertiesService.getString("eai.url")
					+ interfaceId + "_"
					+ super.propertiesService.getString("eai.mode");
		}

		logger.debug("###### EAI End Point URL : " + endPointUrl);

		String auth = super.propertiesService.getString("eai.userid") + ":"
				+ super.propertiesService.getString("eai.userpw");
		HttpPost request = new HttpPost(endPointUrl);
		StringEntity stringEntity = new StringEntity(parameter.toString(),
				Consts.UTF_8);

		request.setHeader("Authorization",
				"Basic " + Base64.encodeBase64String(auth.getBytes()));
		request.addHeader("content-type", "application/json");
		request.setEntity(stringEntity);

		HttpResponse response = httpClient.execute(request);
		BufferedReader rd = null;
		StringBuffer result = new StringBuffer();
		
		try {
			rd = new BufferedReader(new InputStreamReader(response
					.getEntity().getContent()));
	
			for (String line = ""; (line = rd.readLine()) != null;)
				result.append(line);
		}
		catch (Exception ept) {
			logger.error(ept.getMessage());
		}
		finally {
			if (rd != null) rd.close();
		}

		return result;
	}

	/**
	 * 별도의 Transaction으로 로그를 기록한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param interfaceId
	 * @param procDesc
	 * @param logMessage
	 * @throws Exception
	 */
	private void logWriteNewTx(String logRefKey, String interfaceId, String procDesc,
			String logMessage, String isError) throws Exception {
		Map<String, Object> log = new HashMap<String, Object>();

		if (dao.select() > super.propertiesService.getInt("eai.log.maxsize")) {
			Map<String, Object> deletesize = new HashMap<String, Object>();
			deletesize.put("deletesize",
					super.propertiesService.getInt("eai.log.deletesize"));
			dao.delete(deletesize);
		}

		log.put("logRefKey", logRefKey);
		log.put("interfaceId", interfaceId);
		log.put("procDesc", procDesc);
		log.put("logData", logMessage);
		log.put("isError", isError);
		log.put("sendMainYn", ("Y".equals(isError)?"N":"Y"));

		dao.insert(log);
	}

	private void logWriteNewTx(String logRefKey, String interfaceId, String procDesc,
			JSONObject logData, String isError) throws Exception {
		logWriteNewTx(logRefKey, interfaceId, procDesc, logData.toString(), isError);
	}

	private void logWriteNewTx(String logRefKey, String interfaceId, String procDesc,
			Map<String, Object> logData, String isError) throws Exception {
		logWriteNewTx(logRefKey, interfaceId, procDesc, logData.toString(), isError);
	}

	private void logWriteNewTx(String logRefKey, String interfaceId, String procDesc,
			List<?> logData, String isError) throws Exception {
		logWriteNewTx(logRefKey, interfaceId, procDesc,
				DTOUtil.convertListVoToXml(logData), isError);
	}

	private void logWriteNewTx(String logRefKey, String interfaceId, String procDesc,
			Exception ept, String isError) throws Exception {
		logWriteNewTx(logRefKey, interfaceId, procDesc, ept.getMessage(), isError);
	}
}
