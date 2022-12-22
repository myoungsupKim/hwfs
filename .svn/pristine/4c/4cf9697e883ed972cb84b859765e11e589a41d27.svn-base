package hanwha.neo.branch.common.slo.test;

import hanwha.neo.branch.common.approval.dto.SLO_REQUEST;
import hanwha.neo.branch.common.approval.dto.SLO_RESPONSE;
import hanwha.neo.branch.common.slo.service.CommonSloWsProxy;
import hanwha.neo.slo.SLODecrypt4AES;

import java.rmi.RemoteException;

public class TestSloLogin {
    public static String LOCAL_SERVER_END_POINT = "http://127.0.0.1:8080/neo";//245 Test EndPoint
    public static String TEST_SERVER_END_POINT = "http://172.16.223.245/neo";//245 Test EndPoint
    //public static String TEST_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static String QAS_SERVER_END_POINT = "http://172.16.223.245/neo";//245 Test EndPoint
    //public static String QAS_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static String PRD_SERVER_END_POINT = "https://hwhnr.circle.hanwha.com/api";//245 Test EndPoint
    
    public static void main(String[] args) throws RemoteException {
	CommonSloWsProxy proxy = new CommonSloWsProxy();
	proxy.setEndpoint(TEST_SERVER_END_POINT + "/ws/commonslo");
	String encOtaId = "df84248a0c218daf95ac9cbe4686ea8a76f549667f4e49b06c961db357ae9192"; // //사용자 OTA_ID
	
	SLO_REQUEST requst = new SLO_REQUEST();
	
	requst.setENCRYPTED_OTA_ID(encOtaId);
	requst.setENC_TYPE("A");
	
	SLO_RESPONSE response = proxy.login(requst);
	String empNo = SLODecrypt4AES.decrypt(response.getEMP_NO(), "1556889699646683");
	if(empNo != null && empNo != "-1") {
	    System.out.println(empNo);
	} else {
	    System.out.println("ERROR");
	}
    }

}
