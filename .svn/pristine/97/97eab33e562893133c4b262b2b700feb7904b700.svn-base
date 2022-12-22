package com.hwfs.sc.cmn.rmi;

import org.springframework.stereotype.Component;

 /**
 * RMI Server에 접속하여 처리하기 위한 RMI Client
 * - com.hwfs.cmn.rmi.RmiClient를 상속 받아 프로젝트에 맞게 필요한 기능을 추가
 * @ClassName RmiClient.java
 * @Description RmiClient Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 14.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 9. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Component
public class RmiClient extends com.hwfs.cmn.rmi.RmiClient {
	
	
	/**
	 * 이중화 구성에서 상대 서버에 운영로그 대상 사용자 정보 cache를 reload 시킨다.
	 *
	 */
	public void reloadUserIdCache () {
		super.invokeCommand (RmiServiceImpl.CMD_CACHE, RmiServiceImpl.CACHE_RELOAD, "USERID");
	}
}
