package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dao.TransMgmtDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 배송처검색하는 UpjangSearch Service Implementation
 *
 * @ClassName TransMgmtServiceImpl.java
 * @Description TransMgmtServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.11.16    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017.11.16
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/transMgmtService")
public class TransMgmtServiceImpl extends DefaultServiceImpl implements
		TransMgmtService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** TransMgmtDAO Bean 생성 */
	@Resource(name = "/sc/cmn/transMgmtDAO")
	private TransMgmtDAO transMgmtDAO;

	/**
	 * 업장검색 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception {
		return transMgmtDAO.selectList(mapParam);
	}
	
	/**
	 * 업장 사전 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectCheck(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception {
		return transMgmtDAO.selectCheck(mapParam);
	}
	
	/**
	 * 저장.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<LmsMmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception {
		int resultCnt = 0;
		resultCnt = transMgmtDAO.saveList(mapParam);
		if ( "1".equals(mapParam.get("isApply").toString()) ) {
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("V_ADDR_INFO",	String.valueOf(mapParam.get("addr1")));
			inParam.put("V_SABUN",	String.valueOf(loginDTO.getSabun()));
			String callProcName = "SCC_ADDR_PRO";
			transMgmtDAO.callAddrProcedure(inParam, callProcName);
		}
		return resultCnt;
	}
}
