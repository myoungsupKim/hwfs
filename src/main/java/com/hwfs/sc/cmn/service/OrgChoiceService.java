package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

/**
 * 조직정보를 조회한다.
 * 
 * @ClassName OrgChoiceService.java
 * @Description OrgChoiceService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 11.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 11.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrgChoiceService {
	RecordSet selectList() throws Exception;
}
