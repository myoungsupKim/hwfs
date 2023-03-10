package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.dao.SpecmTypeTestArticleMappMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 검체유형 시험항목 관리 ServiceImple Class
 *
 * @ClassName SpecmTypeTestArticleMappMgmtServiceImple.java
 * @Description SpecmTypeTestArticleMappMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 16.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 16.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/specmTypeTestArticleMappMgmtService")
public class SpecmTypeTestArticleMappMgmtServiceImpl extends DefaultServiceImpl implements SpecmTypeTestArticleMappMgmtService {

    @Resource(name = "/ls/lcm/specmTypeTestArticleMappMgmtDAO")
    private SpecmTypeTestArticleMappMgmtDAO specmTypeTestArticleMappMgmtDAO;

    /**
     * 검체유형 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return specmTypeTestArticleMappMgmtDAO.selectList(parameter);
    }

    /**
     * 검체유형 시험항목을 저장한다.
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap searchList, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        String mgrpCd = LimsUtil.checkNull(searchList.get(0).get("mgrpCd"));
        String mcalssCd = LimsUtil.checkNull(searchList.get(0).get("mcalssCd"));
        String sclassCd = LimsUtil.checkNull(searchList.get(0).get("sclassCd"));
        String insptPurp = LimsUtil.checkNull(searchList.get(0).get("insptPurp"));
        String isExcel = LimsUtil.checkNull(searchList.get(0).get("isExcel"), "0");
        String strChk = "0";

        // 먼저 삭제 한다.
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("specmType", specmType);
        param.put("insptPurp", insptPurp);
        if (!isExcel.equals("1")) {	// 엑셀 저장이 아니면
            param.put("mgrpCd", mgrpCd);
            param.put("mcalssCd", mcalssCd);
            param.put("sclassCd", sclassCd);
        }
        //procCnt += specmTypeTestArticleMappMgmtDAO.deleteAllList(param);
        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            parameter.put("specmType", specmType);
            if (!isExcel.equals("1")) {	// 엑셀 저장이 아니면
                parameter.put("mgrpCd", mgrpCd);
                parameter.put("mcalssCd", mcalssCd);
                parameter.put("sclassCd", sclassCd);
            }
            parameter.put("insptPurp", insptPurp);

            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    procCnt += specmTypeTestArticleMappMgmtDAO.insertList(parameter);
                } else {
                    procCnt += specmTypeTestArticleMappMgmtDAO.deleteList(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("articleCd", specmType);

        return retVal;
    }

    /**
     * 전체 삭제
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService#saveDelAllList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveDelAllList(DataSetMap searchList, DataSetMap saveList) throws Exception {
        int procCnt = 0;

        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        String mgrpCd = LimsUtil.checkNull(searchList.get(0).get("mgrpCd"));
        String mcalssCd = LimsUtil.checkNull(searchList.get(0).get("mcalssCd"));
        String sclassCd = LimsUtil.checkNull(searchList.get(0).get("sclassCd"));
        String insptPurp = LimsUtil.checkNull(searchList.get(0).get("insptPurp"));

        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("specmType", specmType);
        parameter.put("mgrpCd", mgrpCd);
        parameter.put("mcalssCd", mcalssCd);
        parameter.put("sclassCd", sclassCd);
        parameter.put("insptPurp", insptPurp);

        procCnt += specmTypeTestArticleMappMgmtDAO.deleteAllList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("specmType", specmType);

        return retVal;
    }

    /**
     * 엑셀업로드 검체유형 시험항목을 저장한다.
     *
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService#saveExlList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveExlList(DataSetMap excelList) throws Exception {
        int procCnt = 0;
        int notProcCnt = 0;
        Map<String, Object> parameter = new HashMap<String, Object>();

        //System.out.println(">>>>>>>>>>>>>>>>>>>>specmTypeTestArticleMappMgmtServiceImpl.saveExlList start<<<<<<<<<<<<<<<<<");
        
        String specmType = null;
        String mgrpCd = null;
        String mcalssCd = null;
        String sclassCd = null;
        String articleCd = null;
        String insptPurp1Yn = null;
        String insptPurp2Yn = null;
        String insptPurp3Yn = null;
        String insptPurp4Yn = null;
        int insptPurp = 0;
        String legalBasis = null;
        String insideBasis = null;
        String basisStand = null;
        String remark = null;

        for (int i = 0; i < excelList.size(); i++) {
        	//데이터정합성체크
        	insptPurp = 0;
        	mgrpCd = LimsUtil.checkNull(excelList.get(i).get("B"));
        	mcalssCd = LimsUtil.checkNull(excelList.get(i).get("D"));
        	sclassCd = LimsUtil.checkNull(excelList.get(i).get("F"));
        	articleCd = LimsUtil.checkNull(excelList.get(i).get("H"));
        	insptPurp1Yn = LimsUtil.checkNull(excelList.get(i).get("J")); //법적+내부기준(내부법)
        	/*
        	insptPurp2Yn = LimsUtil.checkNull(excelList.get(i).get("O"));
        	insptPurp3Yn = LimsUtil.checkNull(excelList.get(i).get("T"));
        	insptPurp4Yn = LimsUtil.checkNull(excelList.get(i).get("Y"));
        	*/

        	//System.out.println(i+1 + "번째 데이터:" + mgrpCd + "-" + mcalssCd + "-" + sclassCd + "-" + articleCd + "-" + insptPurp1Yn + "-" + insptPurp2Yn + "-" + insptPurp3Yn + "-" + insptPurp4Yn);
        	
        	if(!mgrpCd.equals("") && !mcalssCd.equals("") && !sclassCd.equals("") && !articleCd.equals(""))
        	{
        		if(insptPurp1Yn.equals("Y") || insptPurp1Yn.equals("N")) insptPurp++;
        		/*
        		if(insptPurp2Yn.equals("Y") || insptPurp2Yn.equals("N")) insptPurp++;
        		if(insptPurp3Yn.equals("Y") || insptPurp3Yn.equals("N")) insptPurp++;
        		if(insptPurp4Yn.equals("Y") || insptPurp4Yn.equals("N")) insptPurp++;
        		*/
        		
        		if(insptPurp > 0)
        		{
        			//검체타입조회
                    parameter.put("mgrpCd", mgrpCd);
                    parameter.put("mcalssCd", mcalssCd);
                    parameter.put("sclassCd", sclassCd);     
                    parameter.put("articleCd", articleCd);
        			specmType = specmTypeTestArticleMappMgmtDAO.selectSpecmType(parameter);
        			
        			if(!specmType.equals("") && specmType != null)
        			{
        				parameter.put("specmType", specmType);
        				
        				//법적+내부기준(내부법)
        				if(insptPurp1Yn.equals("Y"))
        				{
        					legalBasis = LimsUtil.checkNull(excelList.get(i).get("K"));
        					insideBasis = LimsUtil.checkNull(excelList.get(i).get("L"));
        					basisStand = LimsUtil.checkNull(excelList.get(i).get("M"));
        					remark = LimsUtil.checkNull(excelList.get(i).get("N"));

                			//System.out.println("법적기준(공전법):" + legalBasis + "-" + insideBasis + "-" + basisStand + "-" + remark);
        					
        					if((legalBasis.equals("Y") && insideBasis.equals("Y")) || (!legalBasis.equals("Y") && !insideBasis.equals("Y")))
        					{
        						//법적기준, 내부기준 중 하나만 선택 가능
        						notProcCnt++;
        					}
        					else
        					{
            					parameter.put("insptPurp", "103");
            					parameter.put("legalBasis", legalBasis); 
            					parameter.put("insideBasis", insideBasis); 
            					parameter.put("basisStand", basisStand); 
            					parameter.put("remark", remark); 
            					
            					procCnt += specmTypeTestArticleMappMgmtDAO.insertExlList(parameter);
        					}
        				}
        				if(insptPurp1Yn.equals("N"))
        				{
        					parameter.put("insptPurp", "103");
        					procCnt += specmTypeTestArticleMappMgmtDAO.deleteList(parameter);
        				}
/*
        				//법적+내부기준(공전법)
        				if(insptPurp2Yn.equals("Y"))
        				{
        					legalBasis = LimsUtil.checkNull(excelList.get(i).get("P"));
        					insideBasis = LimsUtil.checkNull(excelList.get(i).get("Q"));
        					basisStand = LimsUtil.checkNull(excelList.get(i).get("R"));
        					remark = LimsUtil.checkNull(excelList.get(i).get("S"));
        					
                			//System.out.println("법적+내부기준(공전법):" + legalBasis + "-" + insideBasis + "-" + basisStand + "-" + remark);
        					
        					if((legalBasis.equals("Y") && insideBasis.equals("Y")) || (!legalBasis.equals("Y") && !insideBasis.equals("Y")))
        					{
        						//법적기준, 내부기준 중 하나만 선택 가능
        						notProcCnt++;
        					}
        					else
        					{
            					parameter.put("insptPurp", "102");
            					parameter.put("legalBasis", legalBasis); 
            					parameter.put("insideBasis", insideBasis); 
            					parameter.put("basisStand", basisStand); 
            					parameter.put("remark", remark); 
            					
            					procCnt += specmTypeTestArticleMappMgmtDAO.insertExlList(parameter);
        					}
        				}
        				if(insptPurp2Yn.equals("N"))
        				{
        					parameter.put("insptPurp", "102");
        					procCnt += specmTypeTestArticleMappMgmtDAO.deleteList(parameter);
        				}

        				//법적+내부기준(내부법)
        				if(insptPurp3Yn.equals("Y"))
        				{
        					legalBasis = LimsUtil.checkNull(excelList.get(i).get("U"));
        					insideBasis = LimsUtil.checkNull(excelList.get(i).get("V"));
        					basisStand = LimsUtil.checkNull(excelList.get(i).get("W"));
        					remark = LimsUtil.checkNull(excelList.get(i).get("X"));
        					
                			//System.out.println("법적+내부기준(내부법):" + legalBasis + "-" + insideBasis + "-" + basisStand + "-" + remark);
        					
        					if((legalBasis.equals("Y") && insideBasis.equals("Y")) || (!legalBasis.equals("Y") && !insideBasis.equals("Y")))
        					{
        						//법적기준, 내부기준 중 하나만 선택 가능
        						notProcCnt++;
        					}
        					else
        					{
            					parameter.put("insptPurp", "103");
            					parameter.put("legalBasis", legalBasis); 
            					parameter.put("insideBasis", insideBasis); 
            					parameter.put("basisStand", basisStand); 
            					parameter.put("remark", remark); 
            					
            					procCnt += specmTypeTestArticleMappMgmtDAO.insertExlList(parameter);
        					}
        				}
        				if(insptPurp3Yn.equals("N"))
        				{
        					parameter.put("insptPurp", "103");
        					procCnt += specmTypeTestArticleMappMgmtDAO.deleteList(parameter);
        				}

        				//Spare Part
        				if(insptPurp4Yn.equals("Y"))
        				{
        					legalBasis = LimsUtil.checkNull(excelList.get(i).get("Z"));
        					insideBasis = LimsUtil.checkNull(excelList.get(i).get("AA"));
        					basisStand = LimsUtil.checkNull(excelList.get(i).get("AB"));
        					remark = LimsUtil.checkNull(excelList.get(i).get("AC"));

                			//System.out.println("Spare Part:" + legalBasis + "-" + insideBasis + "-" + basisStand + "-" + remark);
        					
        					if((legalBasis.equals("Y") && insideBasis.equals("Y")) || (!legalBasis.equals("Y") && !insideBasis.equals("Y")))
        					{
        						//법적기준, 내부기준 중 하나만 선택 가능
        						notProcCnt++;
        					}
        					else
        					{
            					parameter.put("insptPurp", "104");
            					parameter.put("legalBasis", legalBasis); 
            					parameter.put("insideBasis", insideBasis); 
            					parameter.put("basisStand", basisStand); 
            					parameter.put("remark", remark); 
            					
            					procCnt += specmTypeTestArticleMappMgmtDAO.insertExlList(parameter);
        					}
        				}
        				if(insptPurp4Yn.equals("N"))
        				{
        					parameter.put("insptPurp", "104");
        					procCnt += specmTypeTestArticleMappMgmtDAO.deleteList(parameter);
        				}    */    				
        			}
        			else
        			{
            			notProcCnt++;
        			}
        		}
        		else
        		{
        			notProcCnt++;
        		}
        	}
        	else
        	{
    			notProcCnt++;
        	}
        	
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("notProcCnt", notProcCnt);

        return retVal;
    }

    /**
     * 검체유형 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService#selectMappingList(java.util.Map)
    */
    @Override
    public RecordSet selectMappingList(Map<String, Object> parameter) throws Exception {
        return specmTypeTestArticleMappMgmtDAO.selectMappingList(parameter);
    }
    
}
