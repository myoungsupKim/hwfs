package com.hwfs.sc.cmn.rmi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hwfs.sc.cmn.service.LoadCacheService;

 /**
 * Spring RMI Service Implementation
 * - WAS 서버간 통신을 위하여 사용한다. (서버 체크, ehcache 동기화 등)
 * - com.hwfs.cmn.rmi.RmiServiceImpl를 상속받아 프로젝트에 맞게 기능을 추가한다.
 * @ClassName RmiServiceImpl.java
 * @Description RmiServiceImpl Class 
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
public class RmiServiceImpl extends com.hwfs.cmn.rmi.RmiServiceImpl implements RmiService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LoadCacheService Bean 생성 */
	@Autowired
	private LoadCacheService loadCacheService;

	/** CACHE */
	public static final String CMD_CACHE = "EHCACHE";

	/** CACHE Reload */
	public static final String CACHE_RELOAD = "RELOAD";

	/**
	 * Command 호출한다.
	 *
	 * @param strCmd     Command 
	 * @param strCmdType Command 종류
	 * @param strCmdData Command Data
	 * @see com.hwfs.sc.cmn.rmi.RmiService#sendCommand(java.lang.String, java.lang.String, java.lang.String)
	*/
	@Override
	public void invokeCommand(String strCmd, String strCmdType, String strCmdData) {
		logger.info("RmiServiceImpl.invokeCommand:{} {} {}", strCmd, strCmdType, strCmdData);
		
		//EHCACHE 동기화 명령인 경우 처리
		if (strCmd.equalsIgnoreCase(CMD_CACHE) && strCmdType.equalsIgnoreCase(CACHE_RELOAD)) {
			//운영로그 대상 사용자 정보를 캐시에 재로딩 한다. 
			loadCacheService.cacheUserIdLog();
		}
	}

}
