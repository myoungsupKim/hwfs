package hanwha.neo.branch.common.slo.client;

import hanwha.neo.branch.common.approval.dto.SLO_REQUEST;
import hanwha.neo.branch.common.approval.dto.SLO_RESPONSE;
import hanwha.neo.branch.common.slo.service.CommonSloWsProxy;
import hanwha.neo.slo.SLOCrypt4AES;
import hanwha.neo.slo.SLODecrypt4AES;

public class CommonSloClient {
	public static final String LOCAL_SERVER_END_POINT = "http://127.0.0.1:8080/neo";//LOCAL Test EndPoint
    public static final String TEST_SERVER_END_POINT = "http://172.25.241.86/neo";//245 Test EndPoint
	//public static final String TEST_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static final String QAS_SERVER_END_POINT = "http://172.25.241.86/neo";//245 Test EndPoint
	//public static final String QAS_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static final String PRD_SERVER_END_POINT = "https://hwhnr.circle.hanwha.com/api";//PRD EndPoint

    public static final String COMMON_SLO_WS_URI = "/ws/commonslo";
    public static final String SLO_ENC_COMMON_KEY = "1556889699646683";
    
    public static SLO_RESPONSE sloCreate(SLO_REQUEST requst, String client) throws Exception {
    	CommonSloWsProxy proxy = new CommonSloWsProxy();
    	proxy.setEndpoint(getEndpoint(client) + COMMON_SLO_WS_URI);
		return proxy.create(requst);
    }

	public static SLO_RESPONSE sloLogin(SLO_REQUEST requst, String client) throws Exception {
		CommonSloWsProxy proxy = new CommonSloWsProxy();
    	proxy.setEndpoint(getEndpoint(client) + COMMON_SLO_WS_URI);
		return proxy.login(requst);
    }
	
	public static String getAesEncryptedString(String plainText) {
		return SLOCrypt4AES.encrypt(plainText, SLO_ENC_COMMON_KEY);
	}
	
	public static String getAesDecryptedString(String plainText) {
		return SLODecrypt4AES.decrypt(plainText, SLO_ENC_COMMON_KEY);
	}
    
    private static String getEndpoint(String client) {
		if (client != null) {
			client = client.toLowerCase();
			if (client.startsWith("dev")) {
				return TEST_SERVER_END_POINT;
			} else if (client.startsWith("qas")) {
				return QAS_SERVER_END_POINT;
			} else if (client.startsWith("prd")) {
				return PRD_SERVER_END_POINT;
			} else if (client.startsWith("local")) {
				return LOCAL_SERVER_END_POINT;
			}
		}
		return TEST_SERVER_END_POINT;
	}
    
	public static void main(String[] args) throws Exception {
		String empNo = "201300077"; //사용자 사번
		
		// 암호문 사용
		SLO_REQUEST requst = new SLO_REQUEST();
		requst.setEMP_NO(CommonSloClient.getAesEncryptedString(empNo));
		requst.setENC_TYPE("A");
		SLO_RESPONSE response = CommonSloClient.sloCreate(requst, "DEV");
		System.out.println(response.getENCRYPTED_OTA_ID());
		
		requst = new SLO_REQUEST();
		requst.setENCRYPTED_OTA_ID(response.getENCRYPTED_OTA_ID());
		requst.setENC_TYPE("A");
		response = CommonSloClient.sloLogin(requst, "DEV");
		System.out.println(CommonSloClient.getAesDecryptedString(response.getEMP_NO()));
		
		// 평문 사용
		requst = new SLO_REQUEST();
		requst.setEMP_NO(empNo);
		requst.setENC_TYPE("P");
		response = CommonSloClient.sloCreate(requst, "DEV");
		System.out.println(response.getENCRYPTED_OTA_ID());
		
		requst = new SLO_REQUEST();
		requst.setENCRYPTED_OTA_ID(response.getENCRYPTED_OTA_ID());
		requst.setENC_TYPE("P");
		response = CommonSloClient.sloLogin(requst, "DEV");
		System.out.println(response.getEMP_NO());

	}

}
