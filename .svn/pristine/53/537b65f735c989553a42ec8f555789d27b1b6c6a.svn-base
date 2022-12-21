package hanwha.neo.branch.common.slo.test;

import hanwha.neo.branch.common.approval.dto.SLO_REQUEST;
import hanwha.neo.branch.common.approval.dto.SLO_RESPONSE;
import hanwha.neo.branch.common.slo.service.CommonSloWsProxy;
import hanwha.neo.slo.SLOCrypt4AES;

import java.rmi.RemoteException;

public class TestSloCreate {
    public static String LOCAL_SERVER_END_POINT = "http://127.0.0.1:8080/neo";//245 Test EndPoint
    public static String TEST_SERVER_END_POINT = "http://172.16.223.245/neo";//245 Test EndPoint
    //public static String TEST_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static String QAS_SERVER_END_POINT = "http://172.16.223.245/neo";//245 Test EndPoint
    //public static String QAS_SERVER_END_POINT = "http://172.16.223.173/neo";//245 Test EndPoint
    public static String PRD_SERVER_END_POINT = "https://hwhnr.circle.hanwha.com/api";//245 Test EndPoint

    public static void main(String[] args) throws RemoteException {
	CommonSloWsProxy proxy = new CommonSloWsProxy();
	proxy.setEndpoint(TEST_SERVER_END_POINT + "/ws/commonslo");
	String empNo = "9999999990"; // 특정사용자 사용자 사번
	String encEmpNo = SLOCrypt4AES.encrypt(empNo, "1556889699646683");
	
	SLO_REQUEST requst = new SLO_REQUEST();
	
	requst.setEMP_NO(encEmpNo);
	requst.setENC_TYPE("A");
	
	SLO_RESPONSE response = proxy.create(requst);
	System.out.println(response.getENCRYPTED_OTA_ID());
    }

}
