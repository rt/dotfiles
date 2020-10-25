export default {
    validation: {
        email: 'Please enter a valid email.',
        required: 'This field is required',
        number: 'Only numbers are permitted',
        alpha: 'Only letters are permitted',
        alphaNumeric: 'Only letters and numbers are permitted.',
        phone: 'Please enter a valid phone number',
        internationalPhone: 'Please enter a valid phone number',
        ccExpire: 'Invalid expiration date.',
        other: 'Invalid input. Please try again.'
    },
    translations: {
        brand: {
            text: 'Pebble Fields',
        },
        banner: {
            text: 'All Ball',
            subText: 'Diggin Basketball'
        },
        shootout: {
            title: 'Feat1'
        }
    },
    routes: [
        {
            text: 'Pebble Fields',
            route: '/',
            category: '',
        },
        {
            text: 'Reference',
            route: '/reference',
            category: 'footer',
        },
        {
            text: 'My Account',
            route: '/account',
            category: '',
        },
        {
            text: 'Log in',
            route: '/login',
            category: '',
        },
        {
            text: 'User Registration',
            route: '/register',
            category: '',
        },
        {
            text: 'Admin',
            route: '/admin',
            category: 'footer',
            icon: 'blah'
        },
        {
            text: 'Privacy',
            route: '/privacy',
            category: 'footer',
            icon: 'blah'
        },
        {
            text: 'NotFound',
            route: '/blah',
            category: '',
        }
    ],

};
