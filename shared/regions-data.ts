export interface Region {
  slug: string;
  name: string;
  country: "US" | "CA";
  center_lat: number;
  center_lng: number;
}

export const NA_REGIONS: Region[] = [
  { slug: "us-al", name: "Alabama", country: "US", center_lat: 32.806671, center_lng: -86.79113 },
  { slug: "us-ak", name: "Alaska", country: "US", center_lat: 61.370716, center_lng: -152.404419 },
  { slug: "us-az", name: "Arizona", country: "US", center_lat: 33.729759, center_lng: -111.431221 },
  { slug: "us-ca", name: "California", country: "US", center_lat: 36.116203, center_lng: -119.681564 },
  { slug: "us-co", name: "Colorado", country: "US", center_lat: 39.059811, center_lng: -105.311104 },
  { slug: "us-ct", name: "Connecticut", country: "US", center_lat: 41.597782, center_lng: -72.755371 },
  { slug: "us-id", name: "Idaho", country: "US", center_lat: 44.068203, center_lng: -114.742041 },
  { slug: "us-me", name: "Maine", country: "US", center_lat: 44.693947, center_lng: -69.381927 },
  { slug: "us-ma", name: "Massachusetts", country: "US", center_lat: 42.230171, center_lng: -71.530106 },
  { slug: "us-mi", name: "Michigan", country: "US", center_lat: 43.326618, center_lng: -84.536095 },
  { slug: "us-mn", name: "Minnesota", country: "US", center_lat: 45.694454, center_lng: -93.900192 },
  { slug: "us-mt", name: "Montana", country: "US", center_lat: 46.921925, center_lng: -110.454353 },
  { slug: "us-nh", name: "New Hampshire", country: "US", center_lat: 43.452492, center_lng: -71.563896 },
  { slug: "us-nm", name: "New Mexico", country: "US", center_lat: 34.840515, center_lng: -106.248482 },
  { slug: "us-ny", name: "New York", country: "US", center_lat: 42.165726, center_lng: -74.948051 },
  { slug: "us-nc", name: "North Carolina", country: "US", center_lat: 35.630066, center_lng: -79.806419 },
  { slug: "us-or", name: "Oregon", country: "US", center_lat: 44.572021, center_lng: -122.070938 },
  { slug: "us-pa", name: "Pennsylvania", country: "US", center_lat: 40.590752, center_lng: -77.209755 },
  { slug: "us-ut", name: "Utah", country: "US", center_lat: 40.150032, center_lng: -111.862434 },
  { slug: "us-vt", name: "Vermont", country: "US", center_lat: 44.045876, center_lng: -72.710686 },
  { slug: "us-wa", name: "Washington", country: "US", center_lat: 47.400902, center_lng: -121.490494 },
  { slug: "us-wv", name: "West Virginia", country: "US", center_lat: 38.491226, center_lng: -80.954453 },
  { slug: "us-wi", name: "Wisconsin", country: "US", center_lat: 44.268543, center_lng: -89.616508 },
  { slug: "us-wy", name: "Wyoming", country: "US", center_lat: 42.755966, center_lng: -107.30249 },
  { slug: "ca-ab", name: "Alberta", country: "CA", center_lat: 53.933271, center_lng: -116.576504 },
  { slug: "ca-bc", name: "British Columbia", country: "CA", center_lat: 53.726669, center_lng: -127.647621 },
  { slug: "ca-mb", name: "Manitoba", country: "CA", center_lat: 53.760861, center_lng: -98.813876 },
  { slug: "ca-nb", name: "New Brunswick", country: "CA", center_lat: 46.565316, center_lng: -66.461916 },
  { slug: "ca-nl", name: "Newfoundland and Labrador", country: "CA", center_lat: 53.135509, center_lng: -57.660435 },
  { slug: "ca-ns", name: "Nova Scotia", country: "CA", center_lat: 44.682611, center_lng: -63.744311 },
  { slug: "ca-on", name: "Ontario", country: "CA", center_lat: 50.000000, center_lng: -85.000000 },
  { slug: "ca-qc", name: "Quebec", country: "CA", center_lat: 52.939916, center_lng: -73.549136 },
  { slug: "ca-sk", name: "Saskatchewan", country: "CA", center_lat: 52.939916, center_lng: -106.450864 },
];
