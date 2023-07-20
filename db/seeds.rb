karina_avatar = File.open(Rails.root.join('app', 'assets', 'images', 'karina_avatar.jpg'))

# Ahora, creamos el usuario Karina con su información, incluida la imagen de perfil.
karina = User.create!(
        name: 'Karina',
        email: 'karina@mail.com',
        password: '123456',
        password_confirmation: '123456',
        role: 'admin',
        avatar: karina_avatar
)