package com.hwfs.ls.cmn.service;

import java.util.Map;

import hone.core.util.record.RecordSet;

/**
 * Sla I/F Test Serive Class
 *
 * @ClassName SlaTestService.java
 * @Description SlaTestService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SlaTestService {

    Map<String, Object> saveSlaTest(Map<String, Object> parameter) throws Exception;

    RecordSet faxTransferTest(Map<String, Object> parameter) throws Exception;

}
