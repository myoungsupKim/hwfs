package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 외부 DB에 접속하여 처리하는 ServiceImpl
 * - 데이터소스는 이용하지만 TxManager를 이용하지 못하고 직접 commit/rollback 처리해야 함
 * @ClassName GuideJdbcService.java
 * @Description GuideJdbcService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GuideJdbcService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	int saveList(DataSetMap list) throws Exception;
}
