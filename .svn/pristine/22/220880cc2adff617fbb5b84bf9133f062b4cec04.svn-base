package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fsi.dao.PbResultAmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

 /**
 * PbResultAmtServiceImpl에 대한 설명 작성
 * @ClassName PbResultAmtServiceImpl.java
 * @Description PbResultAmtServiceImpl Class 
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
@Service("/ft/fsi/pbResultAmtService")
public class PbResultAmtServiceImpl  extends DefaultServiceImpl implements PbResultAmtService{

	/** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name = "/ft/fsi/pbResultAmtDAO")
	private PbResultAmtDAO pbResultAmtDAO;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbResultAmtService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		List<Map> pbCodeList = pbResultAmtDAO.selectPbCodeStr(mapParam);
		mapParam.put("pbCodeStr", pbCodeList.get(0).get("pbCodeStr").toString());
		
		// 본부전체 체크로직
		if ( LimsUtil.checkNull(mapParam.get("bonbuChk")).equals("1") && !LimsUtil.checkNull(mapParam.get("tmCd")).equals("") ) { 
			String tmCdMod = mapParam.get("tmCd").toString().substring(0,3);
			mapParam.put("tmCd", tmCdMod);
		}

		return pbResultAmtDAO.selectList(mapParam);
	}
	/**
	 * selectPbCode 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbResultAmtService#selectPbCode(java.util.Map)
	*/
	@Override
	public RecordSet selectPbCode(Map<String, Object> mapParam) throws Exception {
		return pbResultAmtDAO.selectPbCode(mapParam);
	}

}
