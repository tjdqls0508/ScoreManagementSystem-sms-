package com.spring.sms.goods.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class GoodsDto {
	
	private int    goodsId;
	private String goodsTitle;
	private String goodsSinger;
	private int    goodsPrice;
	private String goodsComposer;
	private String goodsGenre;
	private int    goodsPoint;
	private Date   goodsUploadDate;
	private int    goodsTotalPage;
	private int    goodsDeliveryPrice;
	private String goodsStatus;
	private String goodsFileName;
	private Date   goodsDeliveryDate;
	private Date   goodsCredate;
	private int    goodsHits;
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getGoodsTitle() {
		return goodsTitle;
	}
	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	public String getGoodsSinger() {
		return goodsSinger;
	}
	public void setGoodsSinger(String goodsSinger) {
		this.goodsSinger = goodsSinger;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getGoodsComposer() {
		return goodsComposer;
	}
	public void setGoodsComposer(String goodsComposer) {
		this.goodsComposer = goodsComposer;
	}
	public String getGoodsGenre() {
		return goodsGenre;
	}
	public void setGoodsGenre(String goodsGenre) {
		this.goodsGenre = goodsGenre;
	}
	public int getGoodsPoint() {
		return goodsPoint;
	}
	public void setGoodsPoint(int goodsPoint) {
		this.goodsPoint = goodsPoint;
	}
	public Date getGoodsUploadDate() {
		return goodsUploadDate;
	}
	public void setGoodsUploadDate(Date goodsUploadDate) {
		this.goodsUploadDate = goodsUploadDate;
	}
	public int getGoodsTotalPage() {
		return goodsTotalPage;
	}
	public void setGoodsTotalPage(int goodsTotalPage) {
		this.goodsTotalPage = goodsTotalPage;
	}
	public int getGoodsDeliveryPrice() {
		return goodsDeliveryPrice;
	}
	public void setGoodsDeliveryPrice(int goodsDeliveryPrice) {
		this.goodsDeliveryPrice = goodsDeliveryPrice;
	}
	public Date getGoodsDeliveryDate() {
		return goodsDeliveryDate;
	}
	public void setGoodsDeliveryDate(Date goodsDeliveryDate) {
		this.goodsDeliveryDate = goodsDeliveryDate;
	}
	public String getGoodsFileName() {
		return goodsFileName;
	}
	public void setGoodsFileName(String goodsFileName) {
		this.goodsFileName = goodsFileName;
	}
	public String getGoodsStatus() {
		return goodsStatus;
	}
	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}
	public Date getGoodsCredate() {
		return goodsCredate;
	}
	public void setGoodsCredate(Date goodsCredate) {
		this.goodsCredate = goodsCredate;
	}
	public int getGoodsHits() {
		return goodsHits;
	}
	public void setGoodsHits(int goodsHits) {
		this.goodsHits = goodsHits;
	}
	
}
