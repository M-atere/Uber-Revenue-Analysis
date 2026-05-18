# Data Dictionary

This dataset consists of 2,000 observations of Uber users and their trip history across four major US metropolitan areas.

| Table | Column Name | Data Type | Description |
| :--- | :--- | :--- | :--- |
| **Users** | `name` | VARCHAR | The full name of the user (Rider or Driver). |
| **Users** | `date_joined` | DATE | The registration date of the user account. |
| **Users** | `city` | VARCHAR | The city of operation (Chicago, Houston, Los Angeles, New York). |
| **Drivers** | `driver_id` | INT | Unique identifier for active drivers. |
| **Drivers** | `rating` | DECIMAL | The average star rating (1-5) of the driver. |
| **Drivers** | `is_active` | INT/BOOLEAN | Binary flag indicating if the driver is actively working (1 = Active). |
| **Riders** | `user_id` | INT | Unique identifier linking the rider back to the main users table. |
| **Trips** | `status` | VARCHAR | The state of the ride request (e.g., 'completed', 'cancelled'). |
| **Trips** | `distance_km` | DECIMAL | The physical distance of the completed trip measured in kilometers. |
| **Trips** | `total_fare` | DECIMAL | The total monetary amount paid for the trip (USD). |

### Dataset Parameters
* **Total Records:** 2,000 Users 
* **User Breakdown:** 1,600 Riders / 400 Drivers
* **Active Driver Supply:** New York (98), Houston (94), Chicago (81), Los Angeles (78)
* **Total Demand (Riders):** Houston (442), Los Angeles (407), Chicago (380), New York (371)
