<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>
  <h1>Vet webapp</h1>

  <h2>Overview</h2>
  <p>
    This web application was developed to solve the information management challenges faced by the veterinary clinic "Charoco". As the clinic expanded, relying on large paper records led to inefficiencies and data loss, affecting customer satisfaction and revenue.
  </p>

  <h2>Solution Description</h2>
  <p>
    The application streamlines data management by connecting to a relational database, enabling veterinary staff to quickly add, update, delete, and search for records. It covers various entities such as owners, veterinarians, medications, consultations, species, breeds, medical specialties, and pets.
  </p>

  <h2>Key Features</h2>
  <ul>
    <li><strong>Login System:</strong> Secure access for veterinary staff.</li>
    <li><strong>Data Management:</strong> Perform CRUD operations on owners, medications, pets, and related records (with consultations available for view only).</li>
    <li><strong>Statistics:</strong> View total sales for the day, month, and year.</li>
    <li><strong>User-Friendly Interface:</strong> Clean and responsive design using HTML, CSS, and Bootstrap.</li>
  </ul>

  <h2>Technical Details</h2>
  <p>
    The system is implemented using the MVC design pattern, with Hibernate facilitating object-relational mapping to a relational database. The database schema is designed to accurately store detailed information about each entity, and additional components such as stored procedures, packages, and triggers ensure data consistency and enhance system functionality.
  </p>

  <h2>Conclusion</h2>
  <p>
    By automating data management, this application reduces manual errors and saves valuable time. The solution not only improves the efficiency of the clinic's operations but also provides a scalable platform that supports future growth.
  </p>
</body>
</html>
