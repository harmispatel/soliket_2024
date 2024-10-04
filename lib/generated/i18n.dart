import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class S implements WidgetsLocalizations {
  const S();

  static S? current;

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static S? of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Taylor Made";

  String get stripe => "Stripe";

  String get visa => "Visa";

  String get history => "History";

  String get payNow => "Pay Now";

  String get online => "online";

  String get renewPlan => "Renew Plan";

  String get shreeRam => "Shree Ram";

  String get socialMedia => "Social Media";

  String get nearByPlace => "Near By Place";

  String get playList => "Play List";

  String get nearByHotels => "Near By Hotels";

  String get domain => "Domain";

  String get subscription => "Subscription";

  String get addDomain => " Add Domain";

  String get localDomain => "Local Domain";

  String get internationalDomain => "International Domain";

  String get plSelectLogo => "Please Select Logo";

  String get plEnterInternationalDomain =>
      "Please enter your international domain";

  String get offline => "offline";

  String get plEnterLocalDomain => "at least one domain is required";

  String get logo => "Logo";

  String get login => "Login";

  String get nameOfWebsite => "Name Of Website";

  String get dataNotFound => "Data not found";

  String get contactNoNotAvailable => "contact number not available";

  String get email => "Email";

  String get password => "Password";

  String get forgotYourPassword => "Forgot your password";

  String get send => "send";

  String get forgotPassword => "Forgot Password";

  String get forgotPasswordHint =>
      "Please, enter your email address. You will receive a link to create a new password via email.";

  String get signup => "Sign Up";

  String get alreadyHave => "Already have an account?";

  String get name => "Name";

  String get doNotHaveAnAccount =>
      "Don't have an account, click here to SignUp";

  String get modelList => "Model list";

  String get home => "Home";

  String get shop => "Shop";

  String get bag => "Bag";

  String get favorites => "Favorites";

  String get myFavoriteStyle => "My favorite style";

  String get profile => "Profile";

  String get streetCloths => "Street clothes";

  String get searchHint => "Search product";

  String get viewAll => "View all";

  String get viewMeasurement => "View Measurement";

  String get sale => "Sale";

  String get superSaleHere => "Super sale is here...!";

  String get newText => "New";

  String get youHave => "You’ve never seen it before!";

  String get categories => "Categories";

  String get accessories => "Accessories";

  String get individualCampaign => "Individual Campaign";

  String get womenClothing => "Women Clothing & Fashion";

  String get menClothing => "Men Clothing & Fashion";

  String get jawellery => "jewellery & Watches";

  String get allProduct => "All product";

  String get filters => "Filters";

  String get priceLowToHigh => "Price: lowest to high";

  String get sortBy => "Sort by";

  String get filter => "Filter";

  String get priceRange => "Price range";

  String get colors => "Colors";

  String get sizes => "Sizes";

  String get measureId => "Measurement Id";

  String get bookAppointment => "Book Appointment";

  String get women => "Women";

  String get men => "Men";

  String get boys => "Boys";

  String get girls => "Girls";

  String get all => "All";

  String get brand => "Brand";

  String get brands => "adidas Originals, Jack & Jones, s.Oliver";

  String get discard => "Discard";

  String get apply => "Apply";

  String get category => "Category";

  String get search => "Search";

  String get myProfile => "My Profile";

  String get editProfile => "Edit profile";

  String get purchaseHistory => "Purchase history";

  String get shippingAddress => "Shipping addresses";

  String get paymentMethod => "Payment methods";

  String get promoCodes => "Promocodes";

  String get myPartnerStores => "My partner Stores";

  String get shopsRequest => "Shop’s request";

  String get myPartnerManufacturers => "My partner manufacturers";

  String get manufacturersRequest => "Manufacturer's Request";

  String get persopnalInfo => "Personal Information";

  String get fullName => "Full Name";

  String get dob => "Date of Birth";

  String get phoneNo => "Phone No.";

  String get website => "Website (if have)";

  String get changePassword => "Change password";

  String get passwordChange => "Password Change";

  String get oldPasswrd => "Old Password";

  String get newPasswrd => "New Password";

  String get confirmPasswrd => "Confirm Password";

  String get savePasswrd => "save password";

  String get color => "Color";

  String get colorSelected => "Color selected";

  String get itemDetails => "Item details";

  String get shippingInfo => "Shipping info";

  String get support => "Support";

  String get youCan => "You can also like this";

  String get sendRequest => "Send request";

  String get sendConnectionRequest => "Send connection request";

  String get addToCart => "Add to cart";

  String get reviews => "Reviews";

  String get ratings => "Ratings";

  String get ratingsAndReview => "Ratings & Reviews";

  String get modelBank => "Model bank profile";

  String get uploadNearBy => "Upload nearby delivery ticket";

  String get dashboard => "Dashboard";

  String get myAlbum => "My album";

  String get myGallery => "My gallery";

  String get myWallet => "My wallet";

  String get myServices => "My services";

  String get appointmentForModeling => "Appointment for Modeling";

  String get publicAlbumPostsApproval => "Public album posts approval";

  String get publicPostRequest => "Public post request";

  String get completedAppointment => "Completed appointment";

  String get conversations => "Conversations";

  String get supportTicket => "Support ticket";

  String get albumPost => "Album post";

  String get manageProfile => "Manage profile";

  String get logOut => "Logout";

  String get createTicket => "Create a Ticket";

  String get create => "Create";

  String get createAppointment => "Create appointment";

  String get cancel => "Cancel";

  String get next => "Next";

  String get back => "Back";

  String get five => "5";

  String get four => "4";

  String get three => "3";

  String get two => "2";

  String get one => "1";

  String get withPhoto => "With photo";

  String get writeReview => "Write a review";

  String get whatIsYour => "What is you rate?";

  String get pleaseShare => "Please share your opinion about the product";

  String get sendReview => "Send Review";

  String get addYourPhoto => "Add your photos";

  String get camera => "camera";

  String get gallery => "gallery";

  String get address => "Address";

  String get postal => "Postal";

  String get postalCode => "Postal code";

  String get city => "City";

  String get state => "State";

  String get country => "Country";

  String get phone => "Phone";

  String get edit => "Edit";

  String get makeThis => "Make This Default";

  String get delete => "Delete";

  String get modelDetails => "Model details";

  String get productCategory => "Product category";

  String get selectProductCategory => "select product category";

  String get selectCategory => "Select category";

  String get selectBrand => "Select brand";

  String get addAttribute => "Add attribute";

  String get selectMeasurement => "Select measurement";

  String get size => "Size";

  String get selectSize => "select size";

  String get target => "Target";

  String get selectTarget => "select target";

  String get purchaseLink => "Purchase Link";

  String get height => "Height";

  String get taylorMadeId => "TaylorMade ID";

  String get addProductTag => "Add product tag";

  String get walletTnxHistory => "Wallet transaction history";

  String get withdraw => "Withdraw";

  String get addYourAddress => "Add your address";

  String get save => "Save";

  String get saveAndPay => "Save & Pay";

  String get update => "Update";

  String get code => "Code";

  String get date => "Date";

  String get amount => "Amount";

  String get message => "Message";

  String get deliveryStatus => "Delivery Status";

  String get paymentstatus => "Payment Status";

  String get view => "View";

  String get request => "Request";

  String get orderSummary => "Order Summary";

  String get customer => "Customer";

  String get dateTime => "Date & Time";

  String get orderStatus => "Order status";

  String get totalOrderAmount => "Total order amount";

  String get shippingMethod => "Shipping method";

  String get orderDetails => "Order Details";

  String get product => "Product";

  String get searchYourProduct => "Search your product";

  String get variation => "Variation";

  String get quantity => "Quantity";

  String get deliveryType => "Delivery Type";

  String get price => "Price";

  String get orderAmount => "Order Amount";

  String get subTotal => "Subtotal";

  String get shipping => "Shipping";

  String get tax => "Tax";

  String get coupon => "Coupon";

  String get total => "Total";

  String get orderCode => "Order Code";

  String get def => "Default";

  String get canceledDel => "Canceled Delivery";

  String get onTheWay => "On The way";

  String get picked => "Picked";

  String get assigned => "Assigned";

  String get assignedDel => "Assigned Delivery";

  String get summary => "Summary";

  String get completedDelivery => "Completed Delivery";

  String get paymentType => "Payment type";

  String get pendingDel => "Pending Delivery";

  String get onTheWayDel => "On The Way Delivery";

  String get collection => "Collection";

  String get earning => "Earnings";

  String get submit => "Submit";

  String get add => "Add";

  String get phoneNumber => "Phone Number";

  String get updateProfile => "Update Profile";

  String get bankDetails => "Bank details";

  String get bankName => "Bank name";

  String get ifscCode => "Bank IFSC code";

  String get accountHolderName => "Account holder name";

  String get accountNo => "Account No.";

  String get updateBankDetails => "Update Bank details";

  String get changeEmail => "Change your email";

  String get updateEmail => "Update Email";

  String get basicInfo => "Basic Info";

  String get completedMeasures => "Completed Measures";

  String get directCompletedMeasurements => "Direct completed measurements";

  String get userMeasures => "User Measurements";

  String get appointments => "Appointments";

  String get directAppointments => "Direct Appointments";

  String get status => "Status";

  String get rejectedStatus => "Rejected Status";

  String get footA => "Foot A(1)";

  String get footB => "Foot B(2)";

  String get footC => "Foot C(3)";

  String get footD => "Foot D(4)";

  String get footE => "Foot E(5)";

  String get footF => "Foot F(6)";

  String get neckCircum => "Neck Circumference(1)";

  String get shoulderto => "Shoulder to shoulder(2)";

  String get chestCircum => "Chest circumference(3)";

  String get underBreast => "Circumference of breast(4)";

  String get waistCircum => "Waist circumference(5)";

  String get backlength => "Back length(6)";

  String get shoulderToWrist => "Shoulder to wrist(7)";

  String get shoulderToElbow => "Shoulder to elbow(8)";

  String get wristToELbow => "Wrist to elbow(9)";

  String get bicepsCircum => "Biceps(circumference)(10)";

  String get foreArm => "Forearm(circumference)(11)";

  String get wristCircum => "Wrist circumference(12)";

  String get waistToAnkle => "Waist to ankle length(13)";

  String get hipCircum => "Hip circumference(14)";

  String get thighCircum => "Thigh circumference(15)";

  String get circumOfKnees => "Circumference of knees(16)";

  String get calfCircum => "Calf circumference(17)";

  String get crotchToAnkle => "Crotch to ankle(18)";

  String get kneesToAnkle => "Knees to ankle(19)";

  String get ankleCircum => "Ankle circumference(20)";

  String get nectToANkle => "Neck to ankle(21)";

  String get availability => "Availability";

  String get from => "From";

  String get to => "To";

  String get ordersTM => "Orders(This Month)";

  String get orders => "Orders";

  String get catWise => "Category wise product count";

  String get addNewPro => "Add New Product";

  String get productRepairRequest => "Product repair request";

  String get requests => "Requests";

  String get shopSetting => "Shop Setting";

  String get paymentHistory => "Payment History";

  String get moneyWithdraw => "Money Withdraw";

  String get commHistory => "Commission History";

  String get availAndComm => "Availability and Commission";

  String get modelLists => "Models List";

  String get viewAllPost => "View All Post";

  String get requestToModel => "Requests To Model";

  String get uploadFiles => "Upload Files";

  String get feature => "Featured/Unfeatured";

  String get published => "Published/Unpublished";

  String get duplicate => "Duplicate";

  String get action => "Action";

  String get updateProduct => "Update Product";

  String get general => "General";

  String get media => "Media";

  String get priceAndStock => "Price & Stock";

  String get productInfo => "Product Info.";

  String get productName => "Product Name";

  String get brandd => "Brands";

  String get unit => "Unit";

  String get unitHint => "Unit (e.g KG, Pc etc)";

  String get miniPurch => "Minimum Purchase Qty.";

  String get tags => "Tags";

  String get isPersonalize => "Is Personalize Product";

  String get refundable => "Refundable";

  String get productDescription => "Product Description";

  String get description => "Description";

  String get vatTax => "Vat & Tax";

  String get vat => "Vat";

  String get updateNow => "Update Now";

  String get discountDateRange => "Discount Date Range";

  String get discount => "Discount";

  String get unitPrice => "Unit price";

  String get sku => "SKU";

  String get externalLink => "External link";

  String get leaveitBlank =>
      "Leave it blank if you do not use external site link.";

  String get lowStock => "Low Stock Quantity Warning";

  String get showStock => "Show Stock Quantity";

  String get showStockWithQuanity => "Show Stock With Text Only";

  String get hideStock => "Hide Stock";

  String get productVariation => "Product Variation";

  String get attributes => "Attributes";

  String get externalLinkBtn => "External link button text";

  String get productImg => "Product Images";

  String get galleryimg => "Gallery Images";

  String get thumbnailImg => "Thumbnail Image";

  String get chooseFile => "Choose File";

  String get browse => "Browse";

  String get productVideos => "Product Videos";

  String get videoLink => "Video Link";

  String get pdfDescription => "PDF Description";

  String get pdfSpecification => "PDF Specification";

  String get videoProvider => "Video Provider";

  String get modelBankLink => "Model bank link";

  String get seo => "SEO";

  String get metaTitle => "Meta Title";

  String get metaDescription => "Meta description";

  String get metaImage => "Meta Image";

  String get slug => "Slug";

  String get shippingConfig => "Shipping Configuration";

  String get freeShipping => "Free Shipping";

  String get flat => "Flat";

  String get percent => "Percent";

  String get shippingCost => "Shipping Cost";

  String get estimateShipping => "Estimate Shipping Time";

  String get shippingdays => "Shipping Days";

  String get days => "Days";

  String get coupons => "Coupons";

  String get adminComm => "Admin Commission ";

  String get visitShop => "Visit Shop";

  String get shopName => "Shop Name";

  String get shopLogo => "Shop Logo";

  String get shopPhone => "Shop Phone";

  String get shopAddess => "Shop Address";

  String get bannerSettings => "Banner Settings";

  String get banners => "Banners";

  String get facebook => "Facebook";

  String get instagram => "Instagram";

  String get twitter => "Twitter";

  String get google => "Google";

  String get youtube => "Youtube";

  String get socialMediaLink => "Social Media Link";

  String get paymentSetting => "Payment Settings";

  String get yourName => "Your name";

  String get photo => "Photo";

  String get yourPhoto => "Your Phone";

  String get yourPasswrd => "Your Password";

  String get delectProfileType => "Select Profile Type";

  String get bankAccountVeri => "Bank Account Verification";

  String get bankAccountName => "Bank Account Name";

  String get bankAccountNumber => "Bank Account Number";

  String get selectProfileType => "Select Profile Type";

  String get pendingBal => "Pending Balance";

  String get sendWithdrawRequest => "Send Withdraw Request";

  String get modelPost => "Model Post";

  String get measurer => "Measurer";

  String get measurerComm => "Measurer Commission";

  String get owner => "Owner";

  String get appStatus => "Appointment Status";

  String get ticket => "Ticket";

  String get repairRequest => "Repair request";

  String get findNearBy => "Find Nearby";

  String get appointmentStatus => "Appointment Status";

  String get commission => "Commission";

  String get phoneno => "Phone no.";

  String get useTicket => "Use Ticket";

  String get viewTicket => "View Ticket";

  String get validity => "Validity";

  String get close => "Close";

  String get ticketNumber => "Ticket Number";

  String get ticketDetails => "Ticket Details";

  String get ticketId => "Ticket Id";

  String get purchaseTicket => "Purchase ticket";

  String get notifyContractEmail =>
      "Notify to company via added contract email?";

  String get conti => "Continue";

  String get scan => "Scan QR";

  String get or => "OR";

  String get oops => "oops somethings went wrong";

  String get sendAlert => "Send Alert";

  String get sendReq => "Send Request";

  String get alertStatus => "Alert Status";

  String get deliveryStore => "Delivery store";

  String get collectParcel => "Collect parcel";

  String get sendAlertSuccess => "Send Alert Successfully";

  String get sendBookingReq => "Send booking request";

  String get plSelectStore => "Please select any store to continue";

  String get selectBookingReq => "Select booking request";

  String get clickPhoto => "Click Photo";

  String get selectService => "Select service for booking";

  String get agentNumber => "Agent Number";

  String get agentName => "Agent Name";

  String get yourReqis => "Your Request is send Successfully";

  String get serviceReq => "Service request status";

  String get myBookings => "My bookings";

  String get deliveryRequest => "Delivery Request";

  String get parcelPhoto => "Parcel Photo";

  String get bookingSpace => "Booking Space";

  String get customerDetails => "Customer Details";

  String get deliveryAgent => "Delivery Agent";

  String get mobileNo => "Mobile No.";

  String get reject => "Reject";

  String get accept => "Accept";

  String get accepted => "Accepted";

  String get approved => "Approved";

  String get approve => "Approve";

  String get rejected => "Rejected";

  String get pending => "Pending";

  String get expired => "Expired";

  String get unpaid => "Un-paid";

  String get paid => "Paid";

  String get receiveParcel => "Receive Parcel";

  String get completeDelivery => "Complete Delivery";

  String get document => "Document";

  String get plEnterEmail => "Please enter E-mail";

  String get plEnterMobile => "Please enter mobile no.";

  String get plEnterValidEmail => "Please enter valid email address";

  String get plEnterPassword => "Please enter password";

  String get plSelectYourDomain => "Please select your domain";

  String get plEnterReceivedOTP =>
      "Please enter 6 digit OTP received on given email address";

  String get resendOtp => "Resend OTP";

  String get requestOtp => "Request for new OTP in";

  String get seconds => "seconds";

  String get otpValid => "Enter OTP";

  String get noInternet => "No internet";

  String get yourWishList => "your wish list is empty";

  String get empty => "Empty";

  String get bookedHistory => "Booked Orders";

  String get createOrder => "Create Order";

  String get taylorMadeID => "Taylor Made Id";

  String get categoryName => "Category Name";

  String get extraInfo => "Extra Info";

  String get plSelectImage => "Please select image";

  String get plEnterTMId => "Please enter tylor made id";

  String get plSelectManufacturer => "Please select manufacturer";

  String get plEnterProductName => "Please enter product name";

  String get plEnterCategoryName => "Please enter category name";

  String get plEnterPrice => "Please enter price";

  String get plEnterExtraInfo => "Please enter extra info";

  String get selectManufacturer => "Select Manufacturer";

  String get requestedOrders => "Requested orders";

  String get receivedOrders => "Received orders";

  String get myTickets => "My Tickets";

  String get bookingDetails => "Booking details";

  String get addService => "Add service";

  String get updateService => "Update service";

  String get locationService => 'Location service';

  String get locationPermission => 'Location permission';

  String get plEnableLocationService =>
      'Please enable location service to get current location.';

  String get plAllowLocationPermission =>
      'Please allow location permission to get current location.';

  String get enableService => 'Enable service';

  String get allowPermission => 'Allow permission';

  String get done => 'Done';

  String get pinToCurrentLocation => 'Pin to current location';

  String get editAddress => 'Edit address';

  String get addNewAddress => 'Add new address';

  String get pleaseEnterValid => 'Please enter valid address.';

  String get pleaseSelectCountry => 'Please select country';

  String get pleaseSelectState => 'Please select state.';

  String get pleaseSelectCity => 'Please select city.';

  String get pleaseEnterPostal => 'Please enter valid postal code.';

  String get pleaseEnterPhone => 'Please enter valid phone number.';

  String get andWaitWhile => 'and wait while we get your location';

  String get accessCode => 'Access Code';

  String get verify => 'Verify';

  String get uploadPhoto => 'Upload photo';

  String get selectedPhoto => 'Selected photo';

  String get userName => 'User Name';

  String get addAddress => 'Add Address';

  String get myPost => 'My Post';

  String get contractEmailAddress => 'Contract Email Address';

  String get enterPhoneNumer => 'Enter phone number';

  String get enterConfirmPasswrd => 'Enter confirm password';

  String get passwordValidation =>
      'New password and Confirm password must be same';

  String get enterIFSC => 'Please enter IFSC code';

  String get enterAccountHolder => 'Please enter account holder name';

  String get enterAccountNume => 'Please enter account number';

  String get enterBankNume => 'Please enter bank name';

  String get enterMeasurementId => 'Please enter measurement Id';

  String get modelsAlbum => 'Model\'s Album';

  String get noDataFound => 'No Data Found';

  String get location => 'location';

  String get model => 'model';

  String get removeSuccessfully => 'Remove Successfully';

  String get profileName => 'Profile Name';

  String get verifyOTP => 'Verify OTP';

  String get comments => 'Comments';

  String get enterComments => "Enter comments";

  String get addComments => "Add Comments";

  String get resetPassword => "Reset Password";

  String get userDataSyncFailed => "User data sync failed";

  String get typeReplyHere => "type reply here...!";

  String get sendReply => "Send reply";

  String get noTicketAvailable => "No ticket available";

  String get subject => "Subject";

  String get provideDetailed => "Provide a detailed description";

  String get enterSubject => "Enter subject of the ticket";

  String get enterDescription => "Enter description of the ticket";

  String get noCamerafound => "No camera found to record video";

  String get idCopiedToClipBoard => "Id copied to clipboard";

  String get recordedVideo => "Recorded Video";

  String get viewVideo => "View Video";

  String get deleteVideo => "Delete video";

  String get copy => "copy";

  String get mdelBank => "Model Bank";

  String get bodyMeasurement => "Body\nMeasurement";

  String get nearbyDelivery => "Nearby Delivery";

  String get e_Shop => "E-Shop";

  String get repairer => "Repairer";

  String get physical_store => "Physical store";

  String get manufacturer => "Manufacturer";

  String get nearByDelivery => "Nearby Delivery";

  String get ticketOwner => "Ticket Owner";

  String get seller => "Seller";

  String get measurementRequester => "Measurement requester";

  String get bookedOrder => "Booked order";

  String get cart => "Cart";

  String get yourCartIsEmpty => "your cart is empty";

  String get noAppointmentsFound => "No appointment found";

  String get measurementReqRejected => "Measurement request rejected.";

  String get reparationOfProduct =>
      "reparation of this product to fit size can be requested";

  String get returnOftheProduct =>
      "return of this product to a nearby store for immediate product check and money reimbursement is possible";

  String get reqOption => "Request option";

  String get modelBankProfile => "Model bank profile link";

  String get nearByDelTicket => "Nearby delivery ticket";

  String get purchaseSummary => "Purchase Summary";

  String get searchProduct => "Search Product";

  String get noBookingsYet => "No bookings yet";

  String get searchConnectionCode => "Search connection code";

  String get connectionCode => "Connection code";

  String get myConnectionCode => "My Connection code";

  String get alreadyConnected => "Already connected";

  String get reqAlreadySend => "Request already send";

  String get pleaseEnterValidConnection => "Please enter valid connection code";

  String get catName => "Category Name";

  String get notifyCustomer => "Notify Customer";

  String get notifyshop => "Notify shop";

  String get alreadyNotified => "Already notified";

  String get noReqYet => "No request yet...!";

  String get directCompletedMeasurement => "Direct completed measurement";

  String get clothes => "Clothes";

  String get repairerAccountDetails => "Repairer account details";

  String get findNearByRepairer => "Find Nearby Repairer";

  String get shoes => "Shoes";

  String get repairerServiceDetails => "Repairer Service Details";

  String get complete => "Complete";

  String get refresh => "Refresh";

  String get addProduct => "Add new product";

  String get services => "Services";

  String get startConversation => "Start Conversation";

  String get bookService => "Book Service";

  String get pictureOfTheCustomer => "Picture of the customer";

  String get serviceCost => "Service cost";

  String get enterProductName => "Enter product name";

  String get enterMeasureId => "Enter measurement id";

  String get enterServiceCost => "Enter service cost";

  String get enterFromDate => "Enter from date";

  String get enterToDate => "Enter to date";

  String get addPicture => "Add picture";

  String get selectAction => "Select Action";

  String get pendingProduction => "Pending Production";

  String get production => "Production";

  String get completed => "Completed";

  String get enterBrand => "Enter brand";

  String get enterPurchaseLink => "Enter purchase link";

  String get enterHeight => "Enter height";

  String get enterTaylorMadeId => "Enter taylor made id";

  String get clothing => "Clothing";

  String get jewellery => "Jewellery";

  String get watches => "Watches";

  String get hair => "Hair";

  String get skin => "Skin";

  String get makeUp => "Makeup";

  String get footHandNail => "Foot,Hand and Nail";

  String get handbags => "Handbags";

  String get womensFashion => "Women’s fashion";

  String get mensFashion => "Men’s fashion";

  String get womensBeauty => "Women’s beauty";

  String get mensBeauty => "Men’s beauty";

  String get noStoresavailable => "No stores available";

  String get albumName => "Album name";

  String get albumType => "Album type";

  String get public => "Public";

  String get private => "Private";

  String get plEnterAlbumName => "Please enter album name";

  String get plSelectAlbumType => "Please select album type";

  String get plEnterAccessCode => "Please enter access code";

  String get becomePremium => "Become a premium";

  String get profileType => "profile type";

  String get youDontHaveChat => "you Don't have any chats";

  String get commissionPrice => "Commission Price in USD";

  String get set => "Set";

  String get enterCommission => "Enter commission";

  String get viewData => "view data";

  String get address1 => "Address 1";

  String get address2 => "Address 2";

  String get plEnterTicketNo => "Please enter ticket number";

  String get plTakeCourierPic => "Please take courier picture";

  String get plSelectSpace => "Please select any booking space to continue";

  String get plEnterName => "Please enter name";

  String get plEnterWebsiteName => "Please enter website name";

  String get plEnterShopName => "Please enter shop name";

  String get plSelectPayment => "Please select payment method";

  String get plEnterPhoneNo => "Please enter your phone number";

  String get plEnterAddress => "Please enter address";

  String get plEnterAddress1 => "Please enter address1";

  String get plEnterAddress2 => "Please enter address2";

  String get yes => "Yes";

  String get no => "No";

  String get pleaseEnterProductName => "Please enter product name";

  String get pleaseEnterMinimumQuantityToPurchase =>
      "Please enter minimum quantity to purchase";

  String get plSelectPic => "Please select picture";

  String get pleaseSelectThumbImage => "Please select thumb image";

  String get pleaseEnterUnitPrice => "Please select thumb image";

  String get please => "Please select thumb image";

  String get pendingProd => "Pending preparation";

  String get reparationStarted => "Reparation started";

  String get reparationCompleted => "Reparation completed";

  String get packagingRecord => "Packaging Record";

  String get unPackagingRecord => "UnPackaging Record";

  String get returnRecord => "Return Records";

  String get sellerTicketNumber => "Ticket No.1";

  String get customerTicketNumber => "Ticket No.2";

  String get shopTicketNumber => "Ticket No.3";

  String get plEnterTicket1 => "Please enter ticket No.1";

  String get plEnterTicket2 => "Please enter ticket No.2";

  String get plEnterTicket3 => "Please enter ticket No.3";

  String get record => "Record";

  String get playVideo => "Play video";

  String get user => "User";

  String get timeHistory => "Time History";

  String get generatedPictures => "Generated Pictures";

  String get takenPictures => "Taken Pictures";

  String get paypal => "Paypal";

  String get makePayment => "Make Payment";

  String get reportVideo => "Report video";

  String get notifications => "Notifications";

  String get occupation => "Occupation";

  String get verifyAccount => "Verify Account";

  String get plEnterOccupation => "Please enter occupation";

  String get verified => "Verified";

  @override
  // TODO: implement reorderItemDoimport 'dart:async';

  // import 'package:flutter/foundation.dart';
  // import 'package:flutter/material.dart';
  //
  // import '../utils/constant.dart';
  //
  // class S implements WidgetsLocalizations {
  //   const S();
  //
  //   static S? current;
  //
  //   static const GeneratedLocalizationsDelegate delegate =
  //       GeneratedLocalizationsDelegate();
  //
  //   static S? of(BuildContext context) => Localizations.of<S>(context, S);
  //
  //   @override
  //   TextDirection get textDirection => TextDirection.ltr;
  //
  //   String get appName => "Taylor Made";
  //
  //   String get online => "online";
  //
  //   String get offline => "offline";
  //
  //   String get login => "Login";
  //
  //   String get dataNotFound => "Data not found";
  //
  //   String get contactNoNotAvailable => "contact number not available";
  //
  //   String get email => "Email";
  //
  //   String get password => "Password";
  //
  //   String get forgotYourPassword => "Forgot your password";
  //
  //   String get send => "send";
  //
  //   String get forgotPassword => "Forgot Password";
  //
  //   String get forgotPasswordHint =>
  //       "Please, enter your email address. You will receive a link to create a new password via email.";
  //
  //   String get signup => "Sign Up";
  //
  //   String get alreadyHave => "Already have an account?";
  //
  //   String get name => "Name";
  //
  //   String get doNotHaveAnAccount =>
  //       "Don't have an account, click here to SignUp";
  //
  //   String get modelList => "Model list";
  //
  //   String get home => "Home";
  //
  //   String get shop => "Shop";
  //
  //   String get bag => "Bag";
  //
  //   String get favorites => "Favorites";
  //
  //   String get myFavoriteStyle => "My favorite style";
  //
  //   String get profile => "Profile";
  //
  //   String get streetCloths => "Street clothes";
  //
  //   String get searchHint => "Search Categories, product";
  //
  //   String get viewAll => "View all";
  //
  //   String get viewMeasurement => "View Measurement";
  //
  //   String get sale => "Sale";
  //
  //   String get superSaleHere => "Super sale is here...!";
  //
  //   String get newText => "New";
  //
  //   String get youHave => "You’ve never seen it before!";
  //
  //   String get categories => "Categories";
  //
  //   String get accessories => "Accessories";
  //
  //   String get individualCampaign => "Individual Campaign";
  //
  //   String get womenClothing => "Women Clothing & Fashion";
  //
  //   String get menClothing => "Men Clothing & Fashion";
  //
  //   String get jawellery => "jewellery & Watches";
  //
  //   String get allProduct => "All product";
  //
  //   String get filters => "Filters";
  //
  //   String get priceLowToHigh => "Price: lowest to high";
  //
  //   String get sortBy => "Sort by";
  //
  //   String get filter => "Filter";
  //
  //   String get priceRange => "Price range";
  //
  //   String get colors => "Colors";
  //
  //   String get sizes => "Sizes";
  //
  //   String get measureId => "Measurement Id";
  //
  //   String get bookAppointment => "Book Appointment";
  //
  //   String get women => "Women";
  //
  //   String get men => "Men";
  //
  //   String get boys => "Boys";
  //
  //   String get girls => "Girls";
  //
  //   String get all => "All";
  //
  //   String get brand => "Brand";
  //
  //   String get brands => "adidas Originals, Jack & Jones, s.Oliver";
  //
  //   String get discard => "Discard";
  //
  //   String get apply => "Apply";
  //
  //   String get category => "Category";
  //
  //   String get search => "Search";
  //
  //   String get myProfile => "My Profile";
  //
  //   String get editProfile => "Edit profile";
  //
  //   String get purchaseHistory => "Purchase history";
  //
  //   String get shippingAddress => "Shipping addresses";
  //
  //   String get paymentMethod => "Payment methods";
  //
  //   String get promoCodes => "Promocodes";
  //
  //   String get myPartnerStores => "My partner Stores";
  //
  //   String get shopsRequest => "Shop’s request";
  //
  //   String get myPartnerManufacturers => "My partner manufacturers";
  //
  //   String get manufacturersRequest => "Manufacturer's Request";
  //
  //   String get persopnalInfo => "Personal Information";
  //
  //   String get fullName => "Full Name";
  //
  //   String get dob => "Date of Birth";
  //
  //   String get phoneNo => "Phone No.";
  //
  //   String get website => "Website (if have)";
  //
  //   String get changePassword => "Change password";
  //
  //   String get passwordChange => "Password Change";
  //
  //   String get oldPasswrd => "Old Password";
  //
  //   String get newPasswrd => "New Password";
  //
  //   String get confirmPasswrd => "Confirm Password";
  //
  //   String get savePasswrd => "save password";
  //
  //   String get color => "Color";
  //
  //   String get colorSelected => "Color selected";
  //
  //   String get itemDetails => "Item details";
  //
  //   String get shippingInfo => "Shipping info";
  //
  //   String get support => "Support";
  //
  //   String get youCan => "You can also like this";
  //
  //   String get sendRequest => "Send request";
  //
  //   String get sendConnectionRequest => "Send connection request";
  //
  //   String get addToCart => "Add to cart";
  //
  //   String get reviews => "Reviews";
  //
  //   String get ratings => "Ratings";
  //
  //   String get ratingsAndReview => "Ratings & Reviews";
  //
  //   String get modelBank => "Model bank profile";
  //
  //   String get uploadNearBy => "Upload nearby delivery ticket";
  //
  //   String get dashboard => "Dashboard";
  //
  //   String get myAlbum => "My album";
  //
  //   String get myGallery => "My gallery";
  //
  //   String get myWallet => "My wallet";
  //
  //   String get myServices => "My services";
  //
  //   String get appointmentForModeling => "Appointment for Modeling";
  //
  //   String get publicAlbumPostsApproval => "Public album posts approval";
  //
  //   String get publicPostRequest => "Public post request";
  //
  //   String get completedAppointment => "Completed appointment";
  //
  //   String get conversations => "Conversations";
  //
  //   String get supportTicket => "Support ticket";
  //
  //   String get albumPost => "Album post";
  //
  //   String get manageProfile => "Manage profile";
  //
  //   String get logOut => "Logout";
  //
  //   String get createTicket => "Create a Ticket";
  //
  //   String get create => "Create";
  //
  //   String get cancel => "Cancel";
  //
  //   String get next => "Next";
  //
  //   String get back => "Back";
  //
  //   String get five => "5";
  //
  //   String get four => "4";
  //
  //   String get three => "3";
  //
  //   String get two => "2";
  //
  //   String get one => "1";
  //
  //   String get withPhoto => "With photo";
  //
  //   String get writeReview => "Write a review";
  //
  //   String get whatIsYour => "What is you rate?";
  //
  //   String get pleaseShare => "Please share your opinion about the product";
  //
  //   String get sendReview => "Send Review";
  //
  //   String get addYourPhoto => "Add your photos";
  //
  //   String get camera => "camera";
  //
  //   String get gallery => "gallery";
  //
  //   String get address => "Address";
  //
  //   String get postal => "Postal";
  //
  //   String get postalCode => "Postal code";
  //
  //   String get city => "City";
  //
  //   String get state => "State";
  //
  //   String get country => "Country";
  //
  //   String get phone => "Phone";
  //
  //   String get edit => "Edit";
  //
  //   String get makeThis => "Make This Default";
  //
  //   String get delete => "Delete";
  //
  //   String get modelDetails => "Model details";
  //
  //   String get productCategory => "Product category";
  //
  //   String get selectProductCategory => "select product category";
  //
  //   String get selectCategory => "Select category";
  //
  //   String get selectBrand => "Select brand";
  //
  //   String get addAttribute => "Add attribute";
  //
  //   String get selectMeasurement => "Select measurement";
  //
  //   String get size => "Size";
  //
  //   String get selectSize => "select size";
  //
  //   String get target => "Target";
  //
  //   String get selectTarget => "select target";
  //
  //   String get purchaseLink => "Purchase Link";
  //
  //   String get height => "Height";
  //
  //   String get taylorMadeId => "TaylorMade ID";
  //
  //   String get addProductTag => "Add product tag";
  //
  //   String get walletTnxHistory => "Wallet transaction history";
  //
  //   String get withdraw => "Withdraw";
  //
  //   String get addYourAddress => "Add your address";
  //
  //   String get save => "Save";
  //
  //   String get saveAndPay => "Save & Pay";
  //
  //   String get update => "Update";
  //
  //   String get code => "Code";
  //
  //   String get date => "Date";
  //
  //   String get amount => "Amount";
  //
  //   String get message => "Message";
  //
  //   String get deliveryStatus => "Delivery Status";
  //
  //   String get paymentstatus => "Payment Status";
  //
  //   String get view => "View";
  //
  //   String get request => "Request";
  //
  //   String get orderSummary => "Order Summary";
  //
  //   String get customer => "Customer";
  //
  //   String get dateTime => "Date & Time";
  //
  //   String get orderStatus => "Order status";
  //
  //   String get totalOrderAmount => "Total order amount";
  //
  //   String get shippingMethod => "Shipping method";
  //
  //   String get orderDetails => "Order Details";
  //
  //   String get product => "Product";
  //
  //   String get searchYourProduct => "Search your product";
  //
  //   String get variation => "Variation";
  //
  //   String get quantity => "Quantity";
  //
  //   String get deliveryType => "Delivery Type";
  //
  //   String get price => "Price";
  //
  //   String get orderAmount => "Order Amount";
  //
  //   String get subTotal => "Subtotal";
  //
  //   String get shipping => "Shipping";
  //
  //   String get tax => "Tax";
  //
  //   String get coupon => "Coupon";
  //
  //   String get total => "Total";
  //
  //   String get orderCode => "Order Code";
  //
  //   String get def => "Default";
  //
  //   String get canceledDel => "Canceled Delivery";
  //
  //   String get onTheWay => "On The way";
  //
  //   String get picked => "Picked";
  //
  //   String get assigned => "Assigned";
  //
  //   String get assignedDel => "Assigned Delivery";
  //
  //   String get summary => "Summary";
  //
  //   String get completedDelivery => "Completed Delivery";
  //
  //   String get paymentType => "Payment type";
  //
  //   String get pendingDel => "Pending Delivery";
  //
  //   String get onTheWayDel => "On The Way Delivery";
  //
  //   String get collection => "Collection";
  //
  //   String get earning => "Earnings";
  //
  //   String get submit => "Submit";
  //
  //   String get add => "Add";
  //
  //   String get phoneNumber => "Phone Number";
  //
  //   String get updateProfile => "Update Profile";
  //
  //   String get bankDetails => "Bank details";
  //
  //   String get bankName => "Bank name";
  //
  //   String get ifscCode => "Bank IFSC code";
  //
  //   String get accountHolderName => "Account holder name";
  //
  //   String get accountNo => "Account No.";
  //
  //   String get updateBankDetails => "Update Bank details";
  //
  //   String get changeEmail => "Change your email";
  //
  //   String get updateEmail => "Update Email";
  //
  //   String get basicInfo => "Basic Info";
  //
  //   String get completedMeasures => "Completed Measures";
  //
  //   String get directCompletedMeasurements => "Direct completed measurements";
  //
  //   String get userMeasures => "User Measurements";
  //
  //   String get appointments => "Appointments";
  //
  //   String get directAppointments => "Direct Appointments";
  //
  //   String get status => "Status";
  //
  //   String get rejectedStatus => "Rejected Status";
  //
  //   String get footA => "Foot A(1)";
  //
  //   String get footB => "Foot B(2)";
  //
  //   String get footC => "Foot C(3)";
  //
  //   String get footD => "Foot D(4)";
  //
  //   String get footE => "Foot E(5)";
  //
  //   String get footF => "Foot F(6)";
  //
  //   String get neckCircum => "Neck Circumference(1)";
  //
  //   String get shoulderto => "Shoulder to shoulder(2)";
  //
  //   String get chestCircum => "Chest circumference(3)";
  //
  //   String get underBreast => "Circumference of breast(4)";
  //
  //   String get waistCircum => "Waist circumference(5)";
  //
  //   String get backlength => "Back length(6)";
  //
  //   String get shoulderToWrist => "Shoulder to wrist(7)";
  //
  //   String get shoulderToElbow => "Shoulder to elbow(8)";
  //
  //   String get wristToELbow => "Wrist to elbow(9)";
  //
  //   String get bicepsCircum => "Biceps(circumference)(10)";
  //
  //   String get foreArm => "Forearm(circumference)(11)";
  //
  //   String get wristCircum => "Wrist circumference(12)";
  //
  //   String get waistToAnkle => "Waist to ankle length(13)";
  //
  //   String get hipCircum => "Hip circumference(14)";
  //
  //   String get thighCircum => "Thigh circumference(15)";
  //
  //   String get circumOfKnees => "Circumference of knees(16)";
  //
  //   String get calfCircum => "Calf circumference(17)";
  //
  //   String get crotchToAnkle => "Crotch to ankle(18)";
  //
  //   String get kneesToAnkle => "Knees to ankle(19)";
  //
  //   String get ankleCircum => "Ankle circumference(20)";
  //
  //   String get nectToANkle => "Neck to ankle(21)";
  //
  //   String get availability => "Availability";
  //
  //   String get from => "From";
  //
  //   String get to => "To";
  //
  //   String get ordersTM => "Orders(This Month)";
  //
  //   String get orders => "Orders";
  //
  //   String get catWise => "Category wise product count";
  //
  //   String get addNewPro => "Add New Product";
  //
  //   String get productRepairRequest => "Product repair request";
  //
  //   String get requests => "Requests";
  //
  //   String get shopSetting => "Shop Setting";
  //
  //   String get paymentHistory => "Payment History";
  //
  //   String get moneyWithdraw => "Money Withdraw";
  //
  //   String get commHistory => "Commission History";
  //
  //   String get availAndComm => "Availability and Commission";
  //
  //   String get modelLists => "Models List";
  //
  //   String get viewAllPost => "View All Post";
  //
  //   String get requestToModel => "Requests To Model";
  //
  //   String get uploadFiles => "Upload Files";
  //
  //   String get feature => "Featured/Unfeatured";
  //
  //   String get published => "Published/Unpublished";
  //
  //   String get duplicate => "Duplicate";
  //
  //   String get action => "Action";
  //
  //   String get updateProduct => "Update Product";
  //
  //   String get general => "General";
  //
  //   String get media => "Media";
  //
  //   String get priceAndStock => "Price & Stock";
  //
  //   String get productInfo => "Product Info.";
  //
  //   String get productName => "Product Name";
  //
  //   String get brandd => "Brands";
  //
  //   String get unit => "Unit";
  //
  //   String get unitHint => "Unit (e.g KG, Pc etc)";
  //
  //   String get miniPurch => "Minimum Purchase Qty.";
  //
  //   String get tags => "Tags";
  //
  //   String get isPersonalize => "Is Personalize Product";
  //
  //   String get refundable => "Refundable";
  //
  //   String get productDescription => "Product Description";
  //
  //   String get description => "Description";
  //
  //   String get vatTax => "Vat & Tax";
  //
  //   String get vat => "Vat";
  //
  //   String get updateNow => "Update Now";
  //
  //   String get discountDateRange => "Discount Date Range";
  //
  //   String get discount => "Discount";
  //
  //   String get unitPrice => "Unit price";
  //
  //   String get sku => "SKU";
  //
  //   String get externalLink => "External link";
  //
  //   String get leaveitBlank =>
  //       "Leave it blank if you do not use external site link.";
  //
  //   String get lowStock => "Low Stock Quantity Warning";
  //
  //   String get showStock => "Show Stock Quantity";
  //
  //   String get showStockWithQuanity => "Show Stock With Text Only";
  //
  //   String get hideStock => "Hide Stock";
  //
  //   String get productVariation => "Product Variation";
  //
  //   String get attributes => "Attributes";
  //
  //   String get externalLinkBtn => "External link button text";
  //
  //   String get productImg => "Product Images";
  //
  //   String get galleryimg => "Gallery Images";
  //
  //   String get thumbnailImg => "Thumbnail Image";
  //
  //   String get chooseFile => "Choose File";
  //
  //   String get browse => "Browse";
  //
  //   String get productVideos => "Product Videos";
  //
  //   String get videoLink => "Video Link";
  //
  //   String get pdfDescription => "PDF Description";
  //
  //   String get pdfSpecification => "PDF Specification";
  //
  //   String get videoProvider => "Video Provider";
  //
  //   String get modelBankLink => "Model bank link";
  //
  //   String get seo => "SEO";
  //
  //   String get metaTitle => "Meta Title";
  //
  //   String get metaDescription => "Meta description";
  //
  //   String get metaImage => "Meta Image";
  //
  //   String get slug => "Slug";
  //
  //   String get shippingConfig => "Shipping Configuration";
  //
  //   String get freeShipping => "Free Shipping";
  //
  //   String get flat => "Flat";
  //
  //   String get percent => "Percent";
  //
  //   String get shippingCost => "Shipping Cost";
  //
  //   String get estimateShipping => "Estimate Shipping Time";
  //
  //   String get shippingdays => "Shipping Days";
  //
  //   String get days => "Days";
  //
  //   String get coupons => "Coupons";
  //
  //   String get adminComm => "Admin Commission ";
  //
  //   String get visitShop => "Visit Shop";
  //
  //   String get shopName => "Shop Name";
  //
  //   String get shopLogo => "Shop Logo";
  //
  //   String get shopPhone => "Shop Phone";
  //
  //   String get shopAddess => "Shop Address";
  //
  //   String get bannerSettings => "Banner Settings";
  //
  //   String get banners => "Banners";
  //
  //   String get facebook => "Facebook";
  //
  //   String get instagram => "Instagram";
  //
  //   String get twitter => "Twitter";
  //
  //   String get google => "Google";
  //
  //   String get youtube => "Youtube";
  //
  //   String get socialMediaLink => "Social Media Link";
  //
  //   String get paymentSetting => "Payment Settings";
  //
  //   String get yourName => "Your name";
  //
  //   String get photo => "Photo";
  //
  //   String get yourPhoto => "Your Phone";
  //
  //   String get yourPasswrd => "Your Password";
  //
  //   String get delectProfileType => "Select Profile Type";
  //
  //   String get bankAccountVeri => "Bank Account Verification";
  //
  //   String get bankAccountName => "Bank Account Name";
  //
  //   String get bankAccountNumber => "Bank Account Number";
  //
  //   String get selectProfileType => "Select Profile Type";
  //
  //   String get pendingBal => "Pending Balance";
  //
  //   String get sendWithdrawRequest => "Send Withdraw Request";
  //
  //   String get modelPost => "Model Post";
  //
  //   String get measurer => "Measurer";
  //
  //   String get measurerComm => "Measurer Commission";
  //
  //   String get owner => "Owner";
  //
  //   String get appStatus => "Appointment Status";
  //
  //   String get ticket => "Ticket";
  //
  //   String get repairRequest => "Repair request";
  //
  //   String get findNearBy => "Find Nearby";
  //
  //   String get appointmentStatus => "Appointment Status";
  //
  //   String get commission => "Commission";
  //
  //   String get phoneno => "Phone no.";
  //
  //   String get useTicket => "Use Ticket";
  //
  //   String get viewTicket => "View Ticket";
  //
  //   String get validity => "Validity";
  //
  //   String get close => "Close";
  //
  //   String get ticketNumber => "Ticket Number";
  //
  //   String get ticketDetails => "Ticket Details";
  //
  //   String get ticketId => "Ticket Id";
  //
  //   String get purchaseTicket => "Purchase ticket";
  //
  //   String get notifyContractEmail =>
  //       "Notify to company via added contract email?";
  //
  //   String get conti => "Continue";
  //
  //   String get scan => "Scan QR";
  //
  //   String get or => "OR";
  //
  //   String get oops => "oops somethings went wrong";
  //
  //   String get sendAlert => "Send Alert";
  //
  //   String get sendReq => "Send Request";
  //
  //   String get alertStatus => "Alert Status";
  //
  //   String get deliveryStore => "Delivery Store";
  //
  //   String get collectParcel => "Collect parcel";
  //
  //   String get sendAlertSuccess => "Send Alert Successfully";
  //
  //   String get sendBookingReq => "Send booking request";
  //
  //   String get plSelectStore => "Please select any store to continue";
  //
  //   String get selectBookingReq => "Select booking request";
  //
  //   String get clickPhoto => "Click Photo";
  //
  //   String get selectService => "Select service for booking";
  //
  //   String get agentNumber => "Agent Number";
  //
  //   String get agentName => "Agent Name";
  //
  //   String get yourReqis => "Your Request is send Successfully";
  //
  //   String get serviceReq => "Service request status";
  //
  //   String get myBookings => "My bookings";
  //
  //   String get deliveryRequest => "Delivery Request";
  //
  //   String get parcelPhoto => "Parcel Photo";
  //
  //   String get bookingSpace => "Booking Space";
  //
  //   String get customerDetails => "Customer Details";
  //
  //   String get deliveryAgent => "Delivery Agent";
  //
  //   String get mobileNo => "Mobile No.";
  //
  //   String get reject => "Reject";
  //
  //   String get accept => "Accept";
  //
  //   String get accepted => "Accepted";
  //
  //   String get approved => "Approved";
  //
  //   String get approve => "Approve";
  //
  //   String get rejected => "Rejected";
  //
  //   String get pending => "Pending";
  //
  //   String get expired => "Expired";
  //
  //   String get unpaid => "Un-paid";
  //
  //   String get paid => "Paid";
  //
  //   String get receiveParcel => "Receive Parcel";
  //
  //   String get completeDelivery => "Complete Delivery";
  //
  //   String get document => "Document";
  //
  //   String get plEnterEmail => "Please enter E-mail";
  //
  //   String get plEnterValidEmail => "Please enter valid email address";
  //
  //   String get plEnterPassword => "Please enter password";
  //
  //   String get plEnterReceivedOTP =>
  //       "Please enter 6 digit OTP received on given email address";
  //
  //   String get resendOtp => "Resend OTP";
  //
  //   String get requestOtp => "Request for new OTP in";
  //
  //   String get seconds => "seconds";
  //
  //   String get otpValid => "Enter OTP";
  //
  //   String get noInternet => "No internet";
  //
  //   String get yourWishList => "your wish list is empty";
  //
  //   String get empty => "Empty";
  //
  //   String get bookedHistory => "Booked Orders";
  //
  //   String get createOrder => "Create Order";
  //
  //   String get taylorMadeID => "Taylor Made Id";
  //
  //   String get categoryName => "Category Name";
  //
  //   String get extraInfo => "Extra Info";
  //
  //   String get plSelectImage => "Please select image";
  //
  //   String get plEnterTMId => "Please enter tylor made id";
  //
  //   String get plSelectManufacturer => "Please select manufacturer";
  //
  //   String get plEnterProductName => "Please enter product name";
  //
  //   String get plEnterCategoryName => "Please enter category name";
  //
  //   String get plEnterPrice => "Please enter price";
  //
  //   String get plEnterExtraInfo => "Please enter extra info";
  //
  //   String get selectManufacturer => "Select Manufacturer";
  //
  //   String get requestedOrders => "Requested orders";
  //
  //   String get receivedOrders => "Received orders";
  //
  //   String get myTickets => "My Tickets";
  //
  //   String get bookingDetails => "Booking details";
  //
  //   String get addService => "Add service";
  //
  //   String get updateService => "Update service";
  //
  //   String get locationService => 'Location service';
  //
  //   String get locationPermission => 'Location permission';
  //
  //   String get plEnableLocationService =>
  //       'Please enable location service to get current location.';
  //
  //   String get plAllowLocationPermission =>
  //       'Please allow location permission to get current location.';
  //
  //   String get enableService => 'Enable service';
  //
  //   String get allowPermission => 'Allow permission';
  //
  //   String get done => 'Done';
  //
  //   String get pinToCurrentLocation => 'Pin to current location';
  //
  //   String get editAddress => 'Edit address';
  //
  //   String get addNewAddress => 'Add new address';
  //
  //   String get pleaseEnterValid => 'Please enter valid address.';
  //
  //   String get pleaseSelectCountry => 'Please select country';
  //
  //   String get pleaseSelectState => 'Please select state.';
  //
  //   String get pleaseSelectCity => 'Please select city.';
  //
  //   String get pleaseEnterPostal => 'Please enter valid postal code.';
  //
  //   String get pleaseEnterPhone => 'Please enter valid phone number.';
  //
  //   String get andWaitWhile => 'and wait while we get your location';
  //
  //   String get accessCode => 'Access Code';
  //
  //   String get verify => 'Verify';
  //
  //   String get uploadPhoto => 'Upload photo';
  //
  //   String get selectedPhoto => 'Selected photo';
  //
  //   String get userName => 'User Name';
  //
  //   String get addAddress => 'Add Address';
  //
  //   String get myPost => 'My Post';
  //
  //   String get contractEmailAddress => 'Contract Email Address';
  //
  //   String get enterPhoneNumer => 'Enter phone number';
  //
  //   String get enterConfirmPasswrd => 'Enter confirm password';
  //
  //   String get passwordValidation =>
  //       'New password and Confirm password must be same';
  //
  //   String get enterIFSC => 'Please enter IFSC code';
  //
  //   String get enterAccountHolder => 'Please enter account holder name';
  //
  //   String get enterAccountNume => 'Please enter account number';
  //
  //   String get enterBankNume => 'Please enter bank name';
  //
  //   String get enterMeasurementId => 'Please enter measurement Id';
  //
  //   String get modelsAlbum => 'Model\'s Album';
  //
  //   String get noDataFound => 'No Data Found';
  //
  //   String get location => 'location';
  //
  //   String get model => 'model';
  //
  //   String get removeSuccessfully => 'Remove Successfully';
  //
  //   String get profileName => 'Profile Name';
  //
  //   String get verifyOTP => 'Verify OTP';
  //
  //   String get comments => 'Comments';
  //
  //   String get enterComments => "Enter comments";
  //
  //   String get addComments => "Add Comments";
  //
  //   String get resetPassword => "Reset Password";
  //
  //   String get userDataSyncFailed => "User data sync failed";
  //
  //   String get typeReplyHere => "type reply here...!";
  //
  //   String get sendReply => "Send reply";
  //
  //   String get noTicketAvailable => "No ticket available";
  //
  //   String get subject => "Subject";
  //
  //   String get provideDetailed => "Provide a detailed description";
  //
  //   String get enterSubject => "Enter subject of the ticket";
  //
  //   String get enterDescription => "Enter description of the ticket";
  //
  //   String get noCamerafound => "No camera found to record video";
  //
  //   String get idCopiedToClipBoard => "Id copied to clipboard";
  //
  //   String get recordedVideo => "Recorded Video";
  //
  //   String get viewVideo => "View Video";
  //
  //   String get deleteVideo => "Delete video";
  //
  //   String get copy => "copy";
  //
  //   String get mdelBank => "Model Bank";
  //
  //   String get bodyMeasurement => "Body\nMeasurement";
  //
  //   String get nearbyDelivery => "Nearby Delivery";
  //
  //   String get e_Shop => "E-Shop";
  //
  //   String get repairer => "Repairer";
  //
  //   String get physical_store => "Physical store";
  //
  //   String get manufacturer => "Manufacturer";
  //
  //   String get nearByDelivery => "Nearby Delivery";
  //
  //   String get ticketOwner => "Ticket Owner";
  //
  //   String get seller => "Seller";
  //
  //   String get bookedOrder => "Booked order";
  //
  //   String get cart => "Cart";
  //
  //   String get yourCartIsEmpty => "your cart is empty";
  //
  //   String get noAppointmentsFound => "No appointment found";
  //
  //   String get measurementReqRejected => "Measurement request rejected.";
  //
  //   String get reparationOfProduct =>
  //       "reparation of this product to fit size can be requested";
  //
  //   String get returnOftheProduct =>
  //       "return of this product to a nearby store for immediate product check and money reimbursement is possible";
  //
  //   String get reqOption => "Request option";
  //
  //   String get modelBankProfile => "Model bank profile link";
  //
  //   String get nearByDelTicket => "Nearby delivery ticket";
  //
  //   String get purchaseSummary => "Purchase Summary";
  //
  //   String get searchProduct => "Search Product";
  //
  //   String get noBookingsYet => "No bookings yet";
  //
  //   String get searchConnectionCode => "Search connection code";
  //
  //   String get connectionCode => "Connection code";
  //
  //   String get myConnectionCode => "My Connection code";
  //
  //   String get alreadyConnected => "Already connected";
  //
  //   String get reqAlreadySend => "Request already send";
  //
  //   String get pleaseEnterValidConnection => "Please enter valid connection code";
  //
  //   String get catName => "Category Name";
  //
  //   String get notifyCustomer => "Notify Customer";
  //
  //   String get notifyshop => "Notify shop";
  //
  //   String get noReqYet => "No request yet...!";
  //
  //   String get directCompletedMeasurement => "Direct completed measurement";
  //
  //   String get clothes => "Clothes";
  //
  //   String get repairerAccountDetails => "Repairer account details";
  //
  //   String get findNearByRepairer => "Find Nearby Repairer";
  //
  //   String get shoes => "Shoes";
  //
  //   String get repairerServiceDetails => "Repairer Service Details";
  //
  //   String get complete => "Complete";
  //
  //   String get refresh => "Refresh";
  //
  //   String get addProduct => "Add new product";
  //
  //   String get services => "Services";
  //
  //   String get startConversation => "Start Conversation";
  //
  //   String get bookService => "Book Service";
  //
  //   String get pictureOfTheCustomer => "Picture of the customer";
  //
  //   String get serviceCost => "Service cost";
  //
  //   String get enterProductName => "Enter product name";
  //
  //   String get enterMeasureId => "Enter measurement id";
  //
  //   String get enterServiceCost => "Enter service cost";
  //
  //   String get enterFromDate => "Enter from date";
  //
  //   String get enterToDate => "Enter to date";
  //
  //   String get addPicture => "Add picture";
  //
  //   String get selectAction => "Select Action";
  //
  //   String get pendingProduction => "Pending Production";
  //
  //   String get production => "Production";
  //
  //   String get completed => "Completed";
  //
  //   String get enterBrand => "Enter brand";
  //
  //   String get enterPurchaseLink => "Enter purchase link";
  //
  //   String get enterHeight => "Enter height";
  //
  //   String get enterTaylorMadeId => "Enter taylor made id";
  //
  //   String get clothing => "Clothing";
  //
  //   String get jewellery => "Jewellery";
  //
  //   String get watches => "Watches";
  //
  //   String get hair => "Hair";
  //
  //   String get skin => "Skin";
  //
  //   String get makeUp => "Makeup";
  //
  //   String get footHandNail => "Foot,Hand and Nail";
  //
  //   String get handbags => "Handbags";
  //
  //   String get womensFashion => "Women’s fashion";
  //
  //   String get mensFashion => "Men’s fashion";
  //
  //   String get womensBeauty => "Women’s beauty";
  //
  //   String get mensBeauty => "Men’s beauty";
  //
  //   String get noStoresavailable => "No stores available";
  //
  //   String get albumName => "Album name";
  //
  //   String get albumType => "Album type";
  //
  //   String get public => "Public";
  //
  //   String get private => "Private";
  //
  //   String get plEnterAlbumName => "Please enter album name";
  //
  //   String get plSelectAlbumType => "Please select album type";
  //
  //   String get plEnterAccessCode => "Please enter access code";
  //
  //   String get becomePremium => "Become a premium";
  //
  //   String get profileType => "profile type";
  //
  //   String get youDontHaveChat => "you Don't have any chats";
  //
  //   String get commissionPrice => "Commission Price in USD";
  //
  //   String get set => "Set";
  //
  //   String get enterCommission => "Enter commission";
  //
  //   String get viewData => "view data";
  //
  //   String get address1 => "Address 1";
  //
  //   String get address2 => "Address 2";
  //
  //   String get plEnterTicketNo => "Please enter ticket number";
  //
  //   String get plTakeCourierPic => "Please take courier picture";
  //
  //   String get plSelectSpace => "Please select any booking space to continue";
  //
  //   String get plEnterName => "Please enter name";
  //
  //   String get plEnterPhoneNo => "Please enter your phone number";
  //
  //   String get plEnterAddress => "Please enter address";
  //
  //   String get plEnterAddress1 => "Please enter address1";
  //
  //   String get plEnterAddress2 => "Please enter address2";
  //
  //   String get yes => "Yes";
  //
  //   String get no => "No";
  //
  //   String get pleaseEnterProductName => "Please enter product name";
  //
  //   String get pleaseEnterMinimumQuantityToPurchase =>
  //       "Please enter minimum quantity to purchase";
  //
  //   String get plSelectPic => "Please select picture";
  //
  //   String get pleaseSelectThumbImage => "Please select thumb image";
  //
  //   String get pleaseEnterUnitPrice => "Please select thumb image";
  //
  //   String get please => "Please select thumb image";
  //
  //   String get pendingProd => "Pending preparation";
  //
  //   String get reparationStarted => "Reparation started";
  //
  //   String get reparationCompleted => "Reparation completed";
  //
  //   String get packagingRecord => "Packaging Record";
  //
  //   String get unPackagingRecord => "UnPackaging Record";
  //
  //   String get returnRecord => "Return Records";
  //
  //   String get sellerTicketNumber => "Ticket No.1";
  //
  //   String get customerTicketNumber => "Ticket No.2";
  //
  //   String get shopTicketNumber => "Ticket No.3";
  //
  //   String get record => "Record";
  //
  //   String get timeHistory => "Time History";
  //
  //   String get generatedPictures => "Generated Pictures";
  //
  //   String get takenPictures => "Taken Pictures";
  //
  //   @override
  //   // TODO: implement reorderItemDown
  //   String get reorderItemDown => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemLeft
  //   String get reorderItemLeft => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemRight
  //   String get reorderItemRight => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemToEnd
  //   String get reorderItemToEnd => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemToStart
  //   String get reorderItemToStart => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemUp
  //   String get reorderItemUp => throw UnimplementedError();
  // }
  //
  // class $en extends S {
  //   const $en();
  // }
  //
  // class $mr extends S {
  //   const $mr();
  //
  //   @override
  //   String get appName => "एईआरएफ";
  //
  //   @override
  //   // TODO: implement reorderItemDown
  //   String get reorderItemDown => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemLeft
  //   String get reorderItemLeft => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemRight
  //   String get reorderItemRight => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemToEnd
  //   String get reorderItemToEnd => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemToStart
  //   String get reorderItemToStart => throw UnimplementedError();
  //
  //   @override
  //   // TODO: implement reorderItemUp
  //   String get reorderItemUp => throw UnimplementedError();
  // }
  //
  // class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  //   const GeneratedLocalizationsDelegate();
  //
  //   List<Locale> get supportedLocales {
  //     return const <Locale>[
  //       Locale(AppConstants.LANGUAGE_ENGLISH, ""),
  //       Locale(AppConstants.LANGUAGE_MARATHI, ""),
  //     ];
  //   }
  //
  //   LocaleListResolutionCallback listResolution(
  //       {Locale? fallback, bool withCountry = true}) {
  //     return (List<Locale>? locales, Iterable<Locale> supported) {
  //       if (locales == null || locales.isEmpty) {
  //         return fallback ?? supported.first;
  //       } else {
  //         return _resolve(locales.first, fallback!, supported, withCountry);
  //       }
  //     };
  //   }
  //
  //   Locale Function(Locale locale, Iterable<Locale> supported) resolution(
  //       {Locale? fallback, bool withCountry = true}) {
  //     return (Locale locale, Iterable<Locale> supported) {
  //       return _resolve(locale, fallback!, supported, withCountry);
  //     };
  //   }
  //
  //   @override
  //   Future<S> load(Locale locale) {
  //     final String? lang = getLang(locale);
  //     if (lang != null) {
  //       switch (lang) {
  //         case AppConstants.LANGUAGE_MARATHI:
  //           S.current = const $mr();
  //           return SynchronousFuture<S>(S.current!);
  //         case AppConstants.LANGUAGE_ENGLISH:
  //           S.current = const $en();
  //           return SynchronousFuture<S>(S.current!);
  //         default:
  // // NO-OP.
  //       }
  //     }
  //     S.current = const S();
  //     return SynchronousFuture<S>(S.current!);
  //   }
  //
  //   @override
  //   bool isSupported(Locale locale) => _isSupported(locale, true);
  //
  //   @override
  //   bool shouldReload(GeneratedLocalizationsDelegate old) => false;
  //
  //   ///
  //   /// Internal method to resolve a locale from a list of locales.
  //   ///
  //   Locale _resolve(Locale? locale, Locale fallback, Iterable<Locale> supported,
  //       bool withCountry) {
  //     if (locale == null || !_isSupported(locale, withCountry)) {
  //       return fallback ?? supported.first;
  //     }
  //
  //     final Locale languageLocale = Locale(locale.languageCode, "");
  //     if (supported.contains(locale)) {
  //       return locale;
  //     } else if (supported.contains(languageLocale)) {
  //       return languageLocale;
  //     } else {
  //       final Locale fallbackLocale = fallback ?? supported.first;
  //       return fallbackLocale;
  //     }
  //   }
  //
  //   ///
  //   /// Returns true if the specified locale is supported, false otherwise.
  //   ///
  //   bool _isSupported(Locale? locale, bool withCountry) {
  //     if (locale != null) {
  //       for (Locale supportedLocale in supportedLocales) {
  // // Language must always match both locales.
  //         if (supportedLocale.languageCode != locale.languageCode) {
  //           continue;
  //         }
  //
  // // If country code matches, return this locale.
  //         if (supportedLocale.countryCode == locale.countryCode) {
  //           return true;
  //         }
  //
  // // If no country requirement is requested, check if this locale has no country.
  //         if (true != withCountry &&
  //             (supportedLocale.countryCode == null ||
  //                 supportedLocale.countryCode!.isEmpty)) {
  //           return true;
  //         }
  //       }
  //     }
  //     return false;
  //   }
  // }
  //
  // String? getLang(Locale? l) => l == null
  //     ? null
  //     : l.countryCode != null && l.countryCode!.isEmpty
  //         ? l.languageCode
  //         : l.toString();wn
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}

class $en extends S {
  const $en();
}

class $hi extends S {
  const $hi();

  @override
  String get appName => "एईआरएफ";

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale(AppConstants.LANGUAGE_ENGLISH, ""),
      Locale(AppConstants.LANGUAGE_HINDI, ""),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale? fallback, bool withCountry = true}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback!, supported, withCountry);
      }
    };
  }

  Locale Function(Locale locale, Iterable<Locale> supported) resolution(
      {Locale? fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback!, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String? lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case AppConstants.LANGUAGE_HINDI:
          S.current = const $hi();
          return SynchronousFuture<S>(S.current!);
        case AppConstants.LANGUAGE_ENGLISH:
          S.current = const $en();
          return SynchronousFuture<S>(S.current!);
        default:
// NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current!);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale? locale, Locale fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale? locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
// Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

// If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

// If no country requirement is requested, check if this locale has no country.
        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode!.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String? getLang(Locale? l) => l == null
    ? null
    : l.countryCode != null && l.countryCode!.isEmpty
        ? l.languageCode
        : l.toString();
