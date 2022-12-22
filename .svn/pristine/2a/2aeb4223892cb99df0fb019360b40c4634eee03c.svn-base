package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * PbGoalMgmtDAO에 대한 설명 작성
 * @ClassName PbGoalMgmtDAO.java
 * @Description PbGoalMgmtDAO Class 
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
@Repository("/ft/fsi/pbGoalMgmtDAO")
public class PbGoalMgmtDAO extends DefaultDAO {

	/** PB목표설정 저장 */
	public int saveList(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.pbGoalMgmtDAO.saveList", mapParam);
	}
	
	/**PB목표설정 삭제 */
	public int deleteList(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.pbGoalMgmtDAO.deleteList", mapParam);
	}
	
	/** PB목표설정 리스트 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.pbGoalMgmtDAO.selectList", mapParam);
    }
	
	/** PB 그룹코드 조회 */
	public RecordSet selectGrpCdList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.pbGoalMgmtDAO.selectGrpCdList", mapParam);
    }
	
	/** PB 직군별 매입율 목표 조회 */
	public RecordSet selectGrpGoalList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.pbGoalMgmtDAO.selectGrpGoalList", mapParam);
    }
	
	/** PB 직군별 매입율 목표  저장 */
	public int saveGrpGoalList(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.pbGoalMgmtDAO.saveGrpGoalList", mapParam);
	}
}
