package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 일마감관리하는 ClosingBooks Service Interface
 * 
 * @ClassName ClosingBooksService.java
 * @Description ClosingBooksService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.13    김명섭        최초생성
 *  
 * </pre>
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ClosingBooksService {

    /**
     * 마감장 팩스발송 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int saveSendList(DataSetMap list) throws Exception;
	
}
