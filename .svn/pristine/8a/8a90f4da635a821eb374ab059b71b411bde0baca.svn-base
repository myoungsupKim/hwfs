package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * PosMenuKeyMgmt에 대한 설명 작성
 * @ClassName PosMenuKeyMgmt.java
 * @Description PosMenuKeyMgmt Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 7.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 7.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PosMenuKeyMgmtService {
	RecordSet selectGrpList(Map<String, Object> parameter) throws Exception;
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectListNew(Map<String, Object> parameter) throws Exception;
	
	int saveData(DataSetMap slePosMenuKeyGrpMgmt, DataSetMap slePosMenuKeyMgmt) throws Exception;
	
	int saveDataGrp(DataSetMap slePosMenuKeyGrpMgmt) throws Exception;
	int saveDataSub(DataSetMap slePosMenuKeyMgmt) throws Exception;
	
	int deleteGrpData(DataSetMap slePosMenuKeyGrpMgmt) throws Exception;
	int deleteSubData(DataSetMap slePosMenuKeyMgmt) throws Exception;

	RecordSet selectListMenu(Map<String, Object> parameter) throws Exception;
	
	int saveDataMove(DataSetMap slePosMenuKeyGrpMgmt) throws Exception;
	int saveDataMoveList(DataSetMap slePosMenuKeyMgmt) throws Exception;
	
	int deleteDataCopy(DataSetMap slePosMenuKeyCopy) throws Exception;
}
