package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * PbGoalMgmtService에 대한 설명 작성
 * @ClassName PbGoalMgmtService.java
 * @Description PbGoalMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 3. 12.   ITO        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 ITO
 * @since 2021. 3. 12.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PbGoalMgmtService {
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception;
	int deleteList(DataSetMap dataSetMap) throws Exception;
	RecordSet selectGrpCdList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectGrpGoalList(Map<String, Object> mapParam) throws Exception;
	int saveGrpGoalList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception;
}
