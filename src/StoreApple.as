package  {
	
	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;
	import starling.events.TouchEvent;
	import starling.core.Starling;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class StoreApple {
		
		private static const elims50:String="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
		private static const elims301:String="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
		private static const elims1000:String="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
		static var productIdList:Vector.<String>;
		static var purchasesAllowed:Boolean = false;
		static var elimAmt:String;
		static var itemHasBeenPurchased:Boolean = false;
		static var hasBeenSetup:Boolean = false;
		
		
		static function setup() {			
			if (!StoreKit.isSupported()) {
				return;
			}
			
			StoreKit.create();
			
			if(!StoreKit.storeKit.isStoreKitAvailable()) {
				return;
			}
			
			populateStore();
		}
		
		
		static function populateStore() {
			productIdList = new Vector.<String>();
			productIdList.push("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			productIdList.push("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			productIdList.push("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			
			StoreKit.storeKit.loadProductDetails(productIdList);
			hasBeenSetup = true;
			
			StoreKit.storeKit.addEventListener(StoreKitEvent.PRODUCT_DETAILS_LOADED, onProducts);
			StoreKit.storeKit.addEventListener(StoreKitErrorEvent.PRODUCT_DETAILS_FAILED, onProductsFailed);
			StoreKit.storeKit.addEventListener(StoreKitEvent.PURCHASE_SUCCEEDED, onPurchaseSuccess);
			StoreKit.storeKit.addEventListener(StoreKitEvent.PURCHASE_CANCELLED, onPurchaseCancel);
			StoreKit.storeKit.addEventListener(StoreKitEvent.PURCHASE_DEFERRED, onPurchaseDeferred);
			StoreKit.storeKit.addEventListener(StoreKitErrorEvent.PURCHASE_FAILED, onPurchaseFailed);
		}
		
		
		static function check() {
			if (!StoreKit.isSupported()) {
				Store.showDenied();
				return;
			}
			if(!StoreKit.storeKit.isStoreKitAvailable()) {
				Store.showDenied();
				return;
			}
			
			if (!hasBeenSetup) {
				populateStore();
			}
			
			StoreKit.storeKit.loadProductDetails(productIdList);
		}
		
		
		// GET PRODUCTS
		static function onProducts(e:StoreKitEvent):void {
			purchasesAllowed = true;
			if (Store.storeHeaderLarge) {
				Store.showItems();
			}
		}
		
		static function onProductsFailed(e:StoreKitErrorEvent):void {
			if (Store.storeHeaderLarge) {
				Store.showDenied();
			}
			purchasesAllowed = false;
		}
		
		
		// PURCHASE PRODUCTS
		static function purchaseElims(id:String) {
			var str:String = String("com.jpwillenborg.dropsy." + id);
			StoreKit.storeKit.purchaseProduct(str, 1);
		}
		
		static function onPurchaseSuccess(e:StoreKitEvent):void {
			if (e.productId == "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") {
				Environment.totalRedux += 50;
				Data.saveObj.totalRedux += 50;
				Data.flushSave();
				elimAmt = "50";
			}
			
			if (e.productId == "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") {
				Environment.totalRedux += 300;
				Data.saveObj.totalRedux += 300;
				Data.flushSave();
				elimAmt = "300";
			}
			
			if (e.productId == "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") {
				Environment.totalRedux += 1000;
				Data.saveObj.totalRedux += 1000;
				Data.flushSave();
				elimAmt = "1,000";
			}
			
			if (Stats.statsSprite) {
				Stats.statsSprite.unflatten();
				Stats.totalElims.text = String(Score.addCommas(Environment.totalRedux));
				Stats.statsSprite.flatten();
			}
			
			itemHasBeenPurchased = false;
			Store.didPurchase = true;
			Store.showStatus(elimAmt);
		}
		
		
		static function onPurchaseCancel(e:StoreKitEvent):void {
			Store.resetItems();
		}
		
		
		static function onPurchaseDeferred(e:StoreKitEvent):void {
		}
		
		
		static function onPurchaseFailed(e:StoreKitErrorEvent):void {
			Store.showDenied();
		}
	}
}
