<!DOCTYPE html>
<html>
<head>
	<title>Veterinaria Charoco</title>
	<style>
		body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
		}

		.container {
			margin: auto;
			width: 80%;
			text-align: center;
		}

		.title {
			font-size: 36px;
			font-weight: bold;
			color: #333333;
			margin-top: 50px;
		}

		.image {
			margin-top: 30px;
		}

		.text {
			font-size: 24px;
			color: #333333;
			margin-top: 20px;
		}

		.comboBox {
			padding: 10px;
			margin-top: 10px;
			width: 300px;
			font-size: 18px;
			color: #333333;
			background-color: #ffffff;
			border: 2px solid #333333;
			border-radius: 5px;
			-webkit-appearance: none;
			-moz-appearance: none;
			appearance: none;
		}

		.button {
			padding: 10px 20px;
			margin-top: 10px;
			font-size: 18px;
			color: #ffffff;
			background-color: #333333;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		.button:hover {
			background-color: #555555;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="title">
			Veterinaria Charoco
		</div>
		<div class="image">
			<img src="animals.png" width="256" height="256" alt="animals">
		</div>
		<div class="text">
			Administrar tabla
		</div>
		<div>
			<select class="comboBox" id="table">
				<option value="Propietario">Propietario</option>
				<option value="Veterinario">Veterinario</option>
				<option value="Medicamento">Medicamento</option>
				<option value="Consulta">Consulta</option>
				<option value="Especie">Especie</option>
				<option value="Raza">Raza</option>
				<option value="Especialidad">Especialidad</option>
				<option value="Mascota">Mascota</option>
                                <option value="bitacoraMedicamento">Bitacora medicamento</option>
			</select>
			<button class="button" onclick="goToTable()">Ir</button>
		</div>
	</div>
        <button class="button" onclick="goToEstadisticas()">Estadísticas</button>
	<script>
		function goToTable() {
			var table = document.getElementById("table").value;
			window.location.href = table + ".jsp";
		}

		function goToEstadisticas() {
			window.location.href = "estadisticas.jsp";
		}
	</script>
</body>
</html>
