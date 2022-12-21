package hanwha.approval;

import hanwha.neo.modules.approval.ws.ApProcessWsProxy;

/**
 * <p>
 * <b>시스템구분</b> : 전자결재
 * </p>
 * <p>
 * <b>프로그램명</b> : RemoteProcessControl.java
 * </p>
 * <p>
 * <b>기 능</b> : 결재문서제어
 * </p>
 * 
 * @author : 박성수
 */
public class RemoteProcessControl {
	// TODO delete after test
	// private static final String TEST_WS_URI =
	// "http://127.0.0.1:8080/neo/ws/ap/process";

	private static final String TEST_WS_URI = "http://172.25.241.86/neo/ws/ap/process";
	private static final String PRODUCTION_WS_URI = "https://hwhnr.circle.hanwha.com:80/api/ws/ap/process";

	private static final String RETURN_CODE_SUCCESS = "SUCCESS";

	private boolean production;

	private String userId;
	private int userIdType;

	/**
	 * @param production
	 *            Proudction 여부 (true : 운영서버, false : 개발서버)
	 */
	public RemoteProcessControl(boolean production) {
		this.production = production;
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 반려(반송)
	 * </p>
	 * 
	 * @param instanceId
	 *            결재문서아이디
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            반려(반송) 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수
	 */
	public void reject(String instanceId, String serviceName, String memo, String companyId) throws Exception {
		process(instanceId, serviceName, "REJECT", memo, companyId);
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 반려(반송)
	 * </p>
	 * <p>
	 * <b>작성일</b> : 2008. 8. 01.
	 * </p>
	 * 
	 * @param arrInstanceId
	 *            결재문서아이디(배열)
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            반려(반송) 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수 HISTORY :
	 */
	public void reject(String[] arrInstanceId, String serviceName, String memo, String companyId) throws Exception {
		process(arrInstanceId, serviceName, "REJECT", memo, companyId);
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 상신취소
	 * </p>
	 * <p>
	 * <b>작성일</b> : 2008. 8. 01.
	 * </p>
	 * 
	 * @param instanceId
	 *            결재문서아이디
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            상신취소 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수 HISTORY :
	 */
	public void cancel(String instanceId, String serviceName, String memo, String companyId) throws Exception {
		process(instanceId, serviceName, "CANCEL", memo, companyId);
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 상신취소
	 * </p>
	 * 
	 * @param arrInstanceId
	 *            결재문서아이디(배열)
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            상신취소 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수 HISTORY :
	 */
	public void cancel(String[] arrInstanceId, String serviceName, String memo, String companyId) throws Exception {
		process(arrInstanceId, serviceName, "CANCEL", memo, companyId);
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 삭제
	 * </p>
	 * 
	 * @param instanceId
	 *            결재문서아이디
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            삭제 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수 HISTORY :
	 */
	public void delete(String instanceId, String serviceName, String memo, String companyId) throws Exception {
		process(instanceId, serviceName, "DELETE", memo, companyId);
	}

	/**
	 * <p>
	 * <b>기 능</b> : 결재문서 삭제
	 * </p>
	 * 
	 * @param arrInstanceId
	 *            결재문서아이디(배열)
	 * @param serviceName
	 *            결재문서 서비스명 (alias)
	 * @param memo
	 *            삭제 사유
	 * @param companyId
	 *            회사아이디
	 * @throws Exception
	 * @author 박성수 HISTORY :
	 */
	public void delete(String[] arrInstanceId, String serviceName, String memo, String companyId) throws Exception {
		process(arrInstanceId, serviceName, "DELETE", memo, companyId);
	}

	private void process(String[] arrInstanceId, String serviceName, String command, String memo, String companyId) throws Exception {
		// EPAQDAOFacade aqDF = new EPAQDAOFacade(production);
		// AQData[] arrAQData = new AQData[arrInstanceId.length];
		// for(int i=0; i<arrInstanceId.length; i++) {
		// arrAQData[i] = new AQData(arrInstanceId[i], companyId, command, memo,
		// serviceName, getHostInfo(), userId, userIdType+"");
		// }
		// aqDF.insert(arrAQData);

		for (int i = 0; i < arrInstanceId.length; i++) {
			process(arrInstanceId[i], serviceName, command, memo, companyId);
		}
	}

	private void process(String instanceId, String serviceName, String command, String memo, String companyId) throws Exception {
		// EPAQDAOFacade aqDF = new EPAQDAOFacade(production);
		// AQData aqData = new AQData(instanceId, companyId, command, memo,
		// serviceName, getHostInfo(), userId, userIdType+"");
		// aqDF.insert(aqData);

		ApProcessWsProxy apProcessWs;
		if (this.production) {
			apProcessWs = new ApProcessWsProxy(PRODUCTION_WS_URI);
		} else {
			apProcessWs = new ApProcessWsProxy(TEST_WS_URI);
		}

		String resultString = null;
		if (command.equals("REJECT")) {
			resultString = apProcessWs.rejectByInstanceId(instanceId, memo);
		} else if (command.equals("CANCEL")) {
			String type = "userId";
			switch (userIdType) {
			case 0:
				type = "userId";
				break;
			case 1:
				type = "empNo";
				break;
			default:
				type = "userId";
				break;
			}
			resultString = apProcessWs.cancelByInstanceId(instanceId, memo, userId, type);
		} else if (command.equals("DELETE")) {
			// TODO replace
			process(instanceId, serviceName, "CANCEL", memo, companyId);
		} else {
			throw new Exception("There is no action of command '" + command + "'");
		}

		if (!resultString.equals(RETURN_CODE_SUCCESS)) {
			throw new Exception(resultString);
		}

	}

	private String getHostInfo() {
		String hostInfo = "NONE";
		try {
			hostInfo = java.net.InetAddress.getLocalHost().toString();
		} catch (Exception e) {
		}
		return hostInfo;
	}

	/**
	 * <p>
	 * <b>기 능</b> : 사용자아이디 세팅(반려자,상신취소자,삭제자)
	 * </p>
	 * 
	 * @param userId
	 *            사용자아이디
	 * @param userIdType
	 *            0 : 그룹웨어 아이디, 1 : 사번
	 * @author 박성수 HISTORY :
	 */
	public void setUserId(String userId, int userIdType) {
		this.userId = userId;
		this.userIdType = userIdType;
	}

	/**
	 * <p>
	 * <b>기 능</b> :
	 * </p>
	 * <p>
	 * <b>작성일</b> : 2008. 8. 4.
	 * </p>
	 * 
	 * @param args
	 * @author chelobek HISTORY :
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		boolean production = false;
		RemoteProcessControl rpc = new RemoteProcessControl(production);
		String[] arrInstanceId = { "5585056" };
		rpc.reject(arrInstanceId, "", "", "408");
		System.out.println("done");
	}

}

/*
 * $Log: RemoteProcessControl.java,v $ Revision 1.2 2010/11/25 21:12:28 ghbpark
 * *** empty log message ***
 * 
 * Revision 1.1 2008/08/26 07:19:50 ghbpark *** empty log message ***
 */

