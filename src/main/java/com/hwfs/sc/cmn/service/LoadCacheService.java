package com.hwfs.sc.cmn.service;

import com.hwfs.cmn.listener.InitApplicationService;

 /**
 * JVM 로드 시 초기에 캐시를 로딩하는 Service Interface
 * <pre>
 * - 다양한 데이터 타입으로 인해 프레임워크로 구성할 수 없어 공통 서비스로 구현 함
 * - 시스템 또는 업무에 필요한 정보를 캐시로 로딩
 * </pre>
 * @ClassName LoadCacheService.java
 * @Description LoadCacheService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 2.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface LoadCacheService extends InitApplicationService {
	/**
	 * 동적으로 로깅을 처리하기 위해 등록된 사용자 ID를 캐싱한다.
	 */
	public void cacheUserIdLog ();

}
