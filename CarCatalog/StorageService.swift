import Foundation

protocol Storage: AnyObject {

	var storedCars: [Car] { get }
	func store(cars: [Car])

}

final class StorageService: Storage {

	static let shared: StorageService = StorageService(userDefaults: .standard)

	var selectedCar: Car?
	var onReloadStorage: (() -> Void)?

	private let userDefaults: UserDefaults
	private(set) var storedCars: [Car] = []

	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
		self.loadCars()

//		self.store(cars: [
//			Car(uuid: UUID().uuidString, year: "1991", vendor: "Toyota", model: "Mark II", bodyType: "Sedan"),
//			Car(uuid: UUID().uuidString, year: "1992", vendor: "Lexus", model: "RX350", bodyType: "SUV"),
//			Car(uuid: UUID().uuidString, year: "2020", vendor: "Bugatti", model: "Chiron", bodyType: "Roadster"),
//		])
	}

	func edit(car: Car) {
		if let index = self.storedCars.index(of: car) {
			self.storedCars.remove(at: index)
			self.storedCars.insert(car, at: index - 1)
			self.store(cars: self.storedCars)
		}
	}

	func add(car: Car) {
		self.storedCars.append(car)
		self.store(cars: self.storedCars)
	}

	func remove(car: Car) {
		if let index = self.storedCars.index(of: car) {
			self.storedCars.remove(at: index)
			self.store(cars: self.storedCars)
			self.onReloadStorage?()
		}
	}

	func store(cars: [Car]) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(cars) {
			self.userDefaults.set(encoded, forKey: "storedCars")
		}

		self.onReloadStorage?()
	}

	private func loadCars() {
		if let savedPerson = self.userDefaults.object(forKey: "storedCars") as? Data {
			let decoder = JSONDecoder()
			if let loadedCars = try? decoder.decode([Car].self, from: savedPerson) {
				self.storedCars = loadedCars
			}
		}
	}

}
