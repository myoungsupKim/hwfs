package com.hwfs.batch.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.tobesoft.xplatform.data.DataSet;
import com.tobesoft.xplatform.data.DataTypes;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.batch.rc.rrm.dao.RrmUseSumJobDAO;

@Service("/batch/rc/rrm/rrmUseSumJobService")
public class RrmUseSumJobServiceImpl extends DefaultServiceImpl implements RrmUseSumJobService
{
	@Resource(name = "batch/rc/rrm/rrmUseSumJobDAO")
	private RrmUseSumJobDAO rrmUseSumJobDAO;

	@SuppressWarnings("unused")
	public int saveList() throws Exception
	{
		int insertCnt = 0;
		Map<String, Object> mapParam = new HashMap<String, Object>();

		// 현재일 데이터 삭제
		rrmUseSumJobDAO.delete(mapParam);
		
		RecordSet rs_mst = rrmUseSumJobDAO.selectList(mapParam);

		if( rs_mst != null && rs_mst.size() > 0 )
		{
			Record record = null;
			RecordSet rs_list = null;
			DataSet ds_list = null;
			for( int i = 0; i < rs_mst.size(); i++ )
			{
				record = rs_mst.get(i);
				mapParam.put("upjangCd", record.get("upjangCd"));
				mapParam.put("stdRecipeCd", record.get("stdRecipeCd"));
				mapParam.put("muCd", record.get("muCd"));
				mapParam.put("treeLevel", "999");

				rs_list = recipeList(mapParam);
				 
				ds_list = calApplyQty(rs_list);
				 
				for( int n = 0; n < rs_list.size(); n++ )
				{
					Map<String, Object> rowData = rs_list.get(n);
					rowData.put("mainRecipeCd", record.get("stdRecipeCd"));
					rowData.put("applyQty", ds_list.getDouble(n, "applyQty"));
					rowData.put("investAmt", ds_list.getDouble(n, "investAmt"));
					insertCnt += rrmUseSumJobDAO.insert(rowData);
				}
			}
		}
		
		return insertCnt;
	}

	private RecordSet recipeList(Map<String, Object> mapParam) throws Exception
	{
		RecordSet rs_list = rrmUseSumJobDAO.selectRecipeList(mapParam);

		int level = Integer.parseInt(mapParam.get("treeLevel").toString());

		mapParam.put("treeLevel", "1");

		RecordSet rs_sub = rrmUseSumJobDAO.selectRecipeDetail(mapParam);

		if( level > 1 )
			recipeDetail(rs_list, rs_sub, level, 2, mapParam);
		else
			addRecordSetToRecordSet(rs_list, rs_sub);

		return rs_list;
	}

	private void recipeDetail(RecordSet rs_list, RecordSet rs_sub, int schLevel, int curLevel, Map<String, Object> mapParam) throws Exception
	{
		RecordSet rs_temp = null;

		if( rs_sub != null && rs_sub.size() > 0 )
		{
			for( int i = 0; i < rs_sub.size(); i++ )
			{
				Record record = rs_sub.get(i);
				rs_list.add(record);

				if( record.get("semiGoodsYn").equals("Y") )
				{
					mapParam.put("stdRecipeCd", record.get("materialCd"));
					mapParam.put("treeLevel", curLevel);
					rs_temp = rrmUseSumJobDAO.selectRecipeDetail(mapParam);

					if( curLevel <= schLevel )
						recipeDetail(rs_list, rs_temp, schLevel, curLevel + 1, mapParam);
				}
			}
		}
	}

	private void addRecordSetToRecordSet(RecordSet rs_list, RecordSet rs_sub)
	{
		if( rs_sub != null && rs_sub.size() > 0 )
		{
			for( int i = 0; i < rs_sub.size(); i++ )
			{
				rs_list.add(rs_sub.get(i));
			}
		}
	}

	private DataSet calApplyQty(RecordSet rs_list)
	{
		DataSet ds_list = new DataSet();
		ds_list.addColumn("stdRecipeCd", DataTypes.STRING, 255);
		ds_list.addColumn("materialCd", DataTypes.STRING, 255);
		ds_list.addColumn("needQty", DataTypes.BIG_DECIMAL, 255);
		ds_list.addColumn("sumNeedQty", DataTypes.BIG_DECIMAL, 255);
		ds_list.addColumn("lossRate", DataTypes.BIG_DECIMAL, 255);
		ds_list.addColumn("semiGoodsYn", DataTypes.STRING, 255);
		ds_list.addColumn("treeLevel", DataTypes.BIG_DECIMAL, 255);
		ds_list.addColumn("applyQty", DataTypes.BIG_DECIMAL, 255);
		ds_list.addColumn("investAmt", DataTypes.BIG_DECIMAL, 255);

		Record record = null;
		Map<String, Object> mapParam = new HashMap<String, Object>();
		double fv_needQty = 0.0;
		double fv_investAmt = 0.0;

		for( int i = 0; i < rs_list.size(); i++ )
		{
			record = rs_list.get(i);
			mapParam.put("stdRecipeCd", record.get("stdRecipeCd"));
			mapParam.put("materialCd", record.get("materialCd"));
			mapParam.put("needQty", record.get("needQty"));
			mapParam.put("sumNeedQty", record.get("sumNeedQty"));
			mapParam.put("lossRate", record.get("lossRate"));
			mapParam.put("semiGoodsYn", record.get("semiGoodsYn"));
			mapParam.put("treeLevel", record.get("treeLevel"));
			mapParam.put("applyQty", record.get("applyQty"));
			mapParam.put("investAmt", record.get("investAmt"));

			int nRow = ds_list.newRow();
			ds_list.set(nRow, "stdRecipeCd", mapParam.get("stdRecipeCd"));
			ds_list.set(nRow, "materialCd", mapParam.get("materialCd"));
			ds_list.set(nRow, "needQty", mapParam.get("needQty"));
			ds_list.set(nRow, "sumNeedQty", mapParam.get("sumNeedQty"));
			ds_list.set(nRow, "lossRate", mapParam.get("lossRate"));
			ds_list.set(nRow, "semiGoodsYn", mapParam.get("semiGoodsYn"));
			ds_list.set(nRow, "treeLevel", mapParam.get("treeLevel"));
			ds_list.set(nRow, "applyQty", mapParam.get("applyQty"));
			
			if( ds_list.getInt(nRow, "treeLevel") == 1 )
			{
				fv_needQty += ds_list.getDouble(nRow, "needQty");

				ds_list.set(nRow, "investAmt", mapParam.get("investAmt"));
				fv_investAmt += ds_list.getDouble(nRow, "investAmt");
			}
			else
			{
				ds_list.set(nRow, "investAmt", "");
			}
		}

		ds_list.set(0, "investAmt", Math.round(fv_investAmt * 1000.0) / 1000.0);

		for( int a = ds_list.getRowCount() - 1; a >= 0; a-- )
		{
			int treeLevel = ds_list.getInt(a, "treeLevel");
			double needQty = ds_list.getDouble(a, "needQty");
			String semiGoodsYn = ds_list.getString(a, "semiGoodsYn");
			
			if( treeLevel == 0 )
				needQty = fv_needQty;
			
			if( semiGoodsYn.equals("Y") )
			{
				double nSumNeedQty = 0.0;
				double nSumApplyQty = 0.0;
				
				for( int b = a; b < ds_list.getRowCount(); b++ )
				{
					if( b == a )
					{
						nSumApplyQty = 0.0;
						
						for( int c = b + 1; c < ds_list.getRowCount(); c++ )
						{
							int curLevel =  ds_list.getInt(c, "treeLevel");

							if( treeLevel >= curLevel )	break;

							if( treeLevel + 1 == curLevel )
								nSumApplyQty += ds_list.getDouble(c, "needQty");
						}
						
						if( needQty == 0.0 || nSumApplyQty == 0.0)
							nSumNeedQty = 0.0;
						else
							nSumNeedQty = needQty / nSumApplyQty;

						ds_list.set(b, "applyQty", nSumNeedQty);
					}
					else
					{
						if( ds_list.getString(b, "semiGoodsYn").equals("Y") )
						{
							if( treeLevel >= ds_list.getInt(b, "treeLevel") )
								break;
							else
								continue;
						}
						
						int curTreeLevel	= ds_list.getInt(b, "treeLevel");
						int curLossRate		= ds_list.getInt(b, "lossRate");
						
						if( treeLevel == 0 )
						{
							if( ds_list.getDouble(b, "applyQty") > 0 )
							{
								double dbApplyQty = nSumNeedQty * ds_list.getDouble(b, "applyQty");
								ds_list.set(b, "applyQty", Math.round(dbApplyQty * 100.0) / 100.0);
							}
							else
							{
								if( (treeLevel == curTreeLevel) && (curLossRate > 100) )
								{
									double dbApplyQty = nSumNeedQty * ds_list.getDouble(b, "sumNeedQty");
									ds_list.set(b, "applyQty", Math.round(dbApplyQty * 100.0) / 100.0);
								}
								else
								{
									
									double dbApplyQty = nSumNeedQty * ds_list.getDouble(b, "needQty");
									ds_list.set(b, "applyQty", Math.round(dbApplyQty * 100.0) / 100.0);
								}
							}
						}
						else
						{
							if( ds_list.getDouble(b, "applyQty") > 0 )
							{
								ds_list.set(b, "applyQty", nSumNeedQty * ds_list.getDouble(b, "applyQty"));
							}
							else
							{
								if( curLossRate > 100 )
									ds_list.set(b, "applyQty", nSumNeedQty * ds_list.getDouble(b, "sumNeedQty"));
								else
									ds_list.set(b, "applyQty", nSumNeedQty * ds_list.getDouble(b, "needQty"));
							}
						}
					}
				}
			}
		}
		return ds_list;
	}
}
