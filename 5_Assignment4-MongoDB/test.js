use Ass4;

// 1. Find all listings with listing_url, name, address, host_verification and
// size of host_verification array in the listingsAndReviews collection that
// have a host with at least 3 verifications and collection that have a host
// with a picture url.

db.listingsAndReviews.aggregate([
  {
	$match: {
	  "host.host_verifications": { $exists: true },
	  "host.host_picture_url": { $exists: true, $ne: null },
	  $expr: { $gte: [{ $size: "$host.host_verifications" }, 3] }
	}
  },
  {
	$project: {
	  "listing_url": 1,
	  "name": 1,
	  "address": 1,
	  "host.host_verifications": 1,
	  "host_verifications_count": { $size: "$host.host_verifications" }
	}
  }
]).pretty();
