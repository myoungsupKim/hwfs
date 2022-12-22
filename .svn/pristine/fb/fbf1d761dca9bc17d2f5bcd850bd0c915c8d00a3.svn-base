package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.ProListDAO;
import com.hwfs.sc.cmn.util.Const;

 /**
 * ProListServiceImpl에 대한 설명 작성
 * @ClassName ProListServiceImpl.java
 * @Description ProListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 9.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 9.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/proListService")
public class ProListServiceImpl extends DefaultServiceImpl implements ProListService {
	@Resource(name="/rc/bms/proListDAO")
	private ProListDAO proList;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.ProListService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = proList.selectMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = proList.selectList(parameter);
		}
		 
		return rs;
	}

}
