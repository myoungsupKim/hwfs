package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.VanBrchMapnMgtDAO;
import com.hwfs.sc.cmn.util.StringUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * VAN 사 사업장 매핑 관리하는 Service Implementation
 * 
 * @ClassName VanBrchMapnMgtServiceImpl.java
 * @Description VanBrchMapnMgtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    ChAoS        최초생성
 * </pre>
 * @author 통합영업회계(ISA) : ChAoS
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/vanBrchMapnMgtService")
public class VanBrchMapnMgtServiceImpl extends DefaultServiceImpl implements VanBrchMapnMgtService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** VanBrchMapnMgtDAO Bean 생성 */
	@Resource(name = "/sc/cmn/vanBrchMapnMgtDAO")
	private VanBrchMapnMgtDAO vanBrchMapnMgtDAO;
	
	/**
	 * VAN 사 사업장 매핑 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectVanBrchMapnList(Map<String, Object> mapParam) throws Exception {
		return vanBrchMapnMgtDAO.selectVanBrchMapnList(mapParam);
	}

	/**
	 * VAN 사 SFTP 접속정보를 중복 제거하여 조회한다. (VAN 사별 1건)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectVanSftpConnInfoList(Map<String, Object> mapParam) throws Exception {
		return vanBrchMapnMgtDAO.selectVanSftpConnInfoList(mapParam);
	}
	
}