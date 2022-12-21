package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * PbResultAmtDAO에 대한 설명 작성
 * @ClassName PbResultAmtDAO.java
 * @Description PbResultAmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 3. 30.   ITO        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 ITO
 * @since 2021. 3. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/pbResultAmtDAO")
public class PbResultAmtDAO extends DefaultDAO{
	
	/* 리스트 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.pbResultAmtDAO.selectList", mapParam);
    }
	
	/* 리스트 피벗 where 조건 (유효PB코드) */
	public List<Map> selectPbCodeStr(Map<String, Object> mapParam) throws Exception {
		//Map<String, Object> map = new HashMap<String, Object>();
		return super.queryForList("ft.fsi.pbResultAmtDAO.selectPbCodeStr",mapParam);
	}
	
	/* PB코드 리스트 */
	public RecordSet selectPbCode(Map<String, Object> mapParam) throws Exception {
		//Map<String, Object> map = new HashMap<String, Object>();
		return super.queryForRecordSet("ft.fsi.pbResultAmtDAO.selectPbCode", mapParam);
		
	}
	 

}
