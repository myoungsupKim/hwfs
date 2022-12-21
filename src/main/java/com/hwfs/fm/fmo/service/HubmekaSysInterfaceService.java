package com.hwfs.fm.fmo.service;

import java.util.Map;

import org.springframework.stereotype.Repository;


 /**
 * HubmekaSysInterfaceService에 대한 설명 작성
 * @ClassName HubmekaSysInterfaceService.java
 * @Description HubmekaSysInterfaceService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2022. 08. 05.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/hubmekaSysInterfaceSqlDAO")
public interface HubmekaSysInterfaceService {
 
	public int batchJobSuspense() throws Exception;
	
}
