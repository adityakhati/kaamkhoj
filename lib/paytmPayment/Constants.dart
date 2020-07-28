const PAYMENT_URL = "https://us-central1-kaamkhoj-8f570.cloudfunctions.net/customFunctions/payment";


const ORDER_DATA = {
  "custID": "USER_112233444545",
  "custEmail": "someemail@gmail.com",
  "custPhone": "7777777777"
};

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";